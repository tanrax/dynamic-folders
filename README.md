# Bash folders

![Bash folder brand](assets/social.webp)

Small collection of Bash scripts to launch functionalities in folders when new files appear, such as optimizing videos, converting images or battery management.

- [Video optimizer](#video-optimizer): Folder that watches when new videos are added and optimizes them.
- [Battery hook](#battery-hook): Folder with custom scripts to be launched in different battery states.
- [Image to webp](#image-to-webp): Folder that watches when new image (PNG or JPEG) are added and transform to WebP format.

---

## Video optimizer

Folder that watches when new videos are added and optimizes them.

### Requirements

- `ffmpeg`

Example in Debian.

``` sh
sudo apt install ffmpeg inotify-tools
```

### Install


``` sh
curl -o bash-folders-video-optimizer https://raw.githubusercontent.com/tanrax/bash-folders/main/bash-folders-video-optimizer.sh && chmod +x bash-folders-video-optimizer && sudo rm -f /usr/local/bin/bash-folders-video-optimizer && sudo mv bash-folders-video-optimizer /usr/local/bin && echo "🎉 Successfully installed! 🎉"
```

Test

``` sh
bash-folders-video-optimizer --help
```

### Run

``` sh
bash-folders-video-optimizer --folder [folder to watch]
```

Example.

``` sh
mkdir optimizer
bash-folders-video-optimizer --folder optimizer
```

And leave a video that you want to optimize in the folder `optimizer`.

### Start at operating system startup

#### Option 1: Service

Create a file in `/etc/systemd/system/bash-folders-video-optimizer.service` with the following content.


```ini
[Unit]
Description=Folder that watches when new videos are added and optimizes them.

[Service]
Restart=always
RestartSec=5
User=[user]
ExecStart=bash-folders-video-optimizer --folder [folder to watch]

[Install]
WantedBy=multi-user.target
```

Edit it to your needs.

Recharge services.

``` sh
sudo systemctl daemon-reload
```

And activate it.

``` sh
sudo systemctl enable bash-folders-video-optimizer
sudo systemctl start bash-folders-video-optimizer
```

#### Option 2: Cron

Open.

``` sh
crontab -e
```

Add to document.

``` sh
@reboot bash-folders-video-optimizer --folder [folder to watch] >/dev/null 2>&1 &
```

---

## Battery hook

Folder with custom scripts to be launched in different battery states.

The filename of the scripts, or your custom scripts,  must be:

- `discharging`: When the battery is in use.
- `charging`: When the battery is charging.
- `low`: When it reaches the low percentage. Default 20.
- `high`: When it reaches the high percentage. Default 80.
- `full`: When the battery is full.

They must have **execution permissions**. If any of them do not exist, they will be ignored.

### Install


``` sh
curl -o bash-folders-battery-hook https://raw.githubusercontent.com/tanrax/bash-folders/main/bash-folders-battery-hook.sh && chmod +x bash-folders-battery-hook && sudo rm -f /usr/local/bin/bash-folders-battery-hook && sudo mv bash-folders-battery-hook /usr/local/bin && echo "🎉 Successfully installed! 🎉"
```

Test

``` sh
bash-folders-battery-hook --help
```

### Run

``` sh
bash-folders-battery-hook --folder [folder path]
```

Example.

``` sh
mkdir battery-scripts

bash-folders-battery-hook --folder battery-scripts
```

Inside the folder all the empty scripts will be created, which you will have to edit to include the instructions in Bash.

### Start at operating system startup

#### Option 1: Service

Create a file in `/etc/systemd/system/bash-folders-battery-hook.service` with the following content.


```ini
[Unit]
Description=Folder with custom scripts to be launched in different battery states.

[Service]
Restart=always
RestartSec=5
User=[user]
ExecStart=bash-folders-battery-hook --folder [folder path]

[Install]
WantedBy=multi-user.target
```

Edit it to your needs.

Now you will need the script to run every so often to check the battery status. The best solution is to create a `timer`.

Create a file in `/etc/systemd/system/bash-folders-battery-hook.timer` with the following content.

```ini
[Unit]
Description=Folder with custom scripts to be launched in different battery states every minute.

[Timer]
OnCalendar=*-*-* *:*:00
Persistent=true

[Install]
WantedBy=timers.target
```

Recharge services.

``` sh
sudo systemctl daemon-reload
```

And activate it.

``` sh
sudo systemctl enable bash-folders-battery-hook.timer
sudo systemctl start bash-folders-battery-hook.timer
```

#### Option 2: Cron

Open.

``` sh
crontab -e
```

Add to document.
Collaborations & Pull Requests
``` sh
* * * * * bash-folders-battery-hook --folder [folder path]
```

---

## Image to WebP

Folder that watches when new image (PNG or JPEG) are added and transform to WebP format.

### Requirements

- `webp`

Example in Debian.

``` sh
sudo apt install webp
```

### Install


``` sh
curl -o bash-folders-image-to-webp https://raw.githubusercontent.com/tanrax/bash-folders/main/bash-folders-image-to-webp.sh && chmod +x bash-folders-image-to-webp && sudo rm -f /usr/local/bin/bash-folders-image-to-webp && sudo mv bash-folders-image-to-webp /usr/local/bin && echo "🎉 Successfully installed! 🎉"
```

Test

``` sh
bash-folders-image-to-webp --help
```

### Run

``` sh
bash-folders-image-to-webp --folder [folder to watch]
```

Example.

``` sh
mkdir image-to-webp-converter
bash-folders-image-to-webp --folder image-to-webp-converter
```

And leave a image that you want to optimize in the folder `image-to-webp-converter`.

### Start at operating system startup

#### Option 1: Service

Create a file in `/etc/systemd/system/bash-folders-image-to-webp.service` with the following content.


```ini
[Unit]
Description=Folder that watches when new image (PNG or JPEG) are added and transform to WebP format.

[Service]
Restart=always
RestartSec=5
User=[user]
ExecStart=bash-folders-image-to-webp --folder [folder to watch]

[Install]
WantedBy=multi-user.target
```

Edit it to your needs.

Recharge services.

``` sh
sudo systemctl daemon-reload
```

And activate it.

``` sh
sudo systemctl enable bash-folders-image-to-webp
sudo systemctl start bash-folders-image-to-webp
```

#### Option 2: Cron

Open.

``` sh
crontab -e
```

Add to document.

``` sh
@reboot bash-folders-image-to-webp --folder [folder to watch] >/dev/null 2>&1 &
```

---

## Collaborations & Pull Requests

You must provide the documentation, as well as the scripts present, test that it works well and the script must pass a `shellcheck` (below you will find an example of execution). 

```sh
shellcheck [script]
```
