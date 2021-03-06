class zfs_auto_snapshot::cron(
  $hourly_snaps,      # Number of hourly snapshots to keep
  $daily_snaps,       # Number of daily snapshots to keep
  $weekly_snaps,      # Number of weekly snapshots to keep
  $fs_names,          # List of filesystems to snapshot
  ) {
  $fs_names_str = join($fs_names, " ")

  cron { 'zfssnap_hourly': 
    command  => "/usr/local/sbin/zfs-auto-snapshot --syslog --label hourly --keep $hourly_snaps $fs_names_str",
    user     => 'root',
    minute   => 0,
  }
  cron { 'zfssnap_daily': 
    command  => "/usr/local/sbin/zfs-auto-snapshot --syslog --label daily --keep $daily_snaps $fs_names_str",
    user     => 'root',
    minute   => 0,
    hour     => 0,
  }
  cron { 'zfssnap_weekly': 
    command => "/usr/local/sbin/zfs-auto-snapshot --syslog --label weekly --keep $weekly_snaps $fs_names_str",
    user    => 'root',
    minute  => 0,
    hour    => 0,
    weekday => 1,
  }

}
