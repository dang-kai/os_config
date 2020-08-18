#!/bin/bash
rsync -aP aecloud:/home/dk/453/system/ /home/dk/453/system/
rsync -aP aecloud:/home/dk/453/workspace/ /home/dk/453/workspace/
7z a /home/dk/453_backup.7z /home/dk/453 -p'+D131emfrt!,.'
mv /home/dk/453_backup.7z /home/dk/453_backup.bak
scp /home/dk/453_backup.bak aecloud:/home/dk/
