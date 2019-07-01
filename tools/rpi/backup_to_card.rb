#!/usr/bin/env ruby

require 'open3'

targets = {
    root: {
        dir: "/",
        partition: "backup_root",
        ignorefile: "/rsync-ignore",
    },
    home: {
        dir: "/home",
        partition: "backup_home",
        ignorefile: "/home/rsync-ignore-limited",
    },
}
target_device = ARGV[0] || "/dev/mmcblk0"
output = `lsblk -Pno name,label,mountpoint #{target_device}`
partitions_by_label = {}
output.split("\n").each do |line|
    opts = line.scan(/(\w+)="(.*?)(?<!\\)"/).each_with_object({}) do |match, result|
        result[match.first.downcase.to_sym] = match.last.gsub(/\A"|"\Z/, '')
    end
    unless opts[:label].empty?
        partitions_by_label[opts.delete(:label)] = opts
    end
end

def pipeout(cmd)
    puts cmd
    Open3.popen2e(cmd) do |stdin, stdout, wait_thr|
        loop do
            line = stdout.gets
            break unless line
            STDOUT.print(line)
        end
        exit_status = wait_thr.value
        unless exit_status.success?
            puts "Failed! #{cmd}"
            exit 1
        end
    end
end

targets.each do |target, opts|
    part_label = opts[:partition]
    partition = partitions_by_label[part_label] 
    if partition
        if partition[:mountpoint].empty?
            part_file = "/dev/#{partition[:name]}"
            mountpoint = "/media/backup/#{part_label}"

            "Backing up #{opts[:dir]} to #{part_file}"
            pipeout(%(mkdir -p "#{mountpoint}"))
            pipeout(%(mount "#{part_file}" "#{mountpoint}"))
            pipeout(%(rsync -avxS --exclude-from="#{opts[:ignorefile]}" --delete --delete-after "#{opts[:dir]}" "#{mountpoint}"))
            pipeout(%(umount "#{mountpoint}"))
        else
            puts "Refusing to unmount #{partition[:name]} from #{partition[:mountpoint]}"
        end
    else
        puts "Couldn't find partition labeled #{part_label}"
    end
end

