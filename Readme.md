# Backup LEGENDLab PC

## Setup borgbackup

(as root)

```bash
apt-get install borgbackup
```

generate ssh key (and create user on server)

```bash
ssh-keygen -t ed25519 -C "user@legendlab"
```

and generate ssh config

```bash
Host artemis
   HostName AAA.BBB.CCC.DDD
   port 22
   user legendlab
   IdentityFile ~/.ssh/legendlab
```

add a cron job to run the scripts once every two hours:

```bash
# m h  dom mon dow   command
0 */2 * * * /usr/bin/bash /home/legend/software/LEGENDLab-Backup/backup.sh
15 */2 * * * /usr/bin/bash /home/legend/software/LEGENDLab-Backup/prune.sh
16 */2 * * * /usr/bin/bash /home/legend/software/LEGENDLab-Backup/prune_log.sh
```

(view the crontab with `crontab -l`)

## Use borgbackup

initate borgbackup

```bash
borg init --encryption=none artemis:/mnt/artemis02/users/legendlab/backup/FCDAQ-2025
```

useful commands:

```bash
borg info artemis:/mnt/artemis02/users/legendlab/backup/FCDAQ-2025
borg list artemis:/mnt/artemis02/users/legendlab/backup/FCDAQ-2025
```
