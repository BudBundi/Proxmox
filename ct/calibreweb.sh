#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/BudBundi/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2023 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
   ______      ___ __                  _       __     __  
  / ____/___ _/ (_) /_  ________      | |     / /__  / /_ 
 / /   / __ `/ / / __ \/ ___/ _ \_____| | /| / / _ \/ __ \
/ /___/ /_/ / / / /_/ / /  /  __/_____/ |/ |/ /  __/ /_/ /
\____/\__,_/_/_/_.___/_/   \___/      |__/|__/\___/_.___/ 
                                                          
EOF
}
header_info
echo -e "Loading..."
APP="Calibre-Web"
var_disk="4"
var_cpu="2"
var_ram="1024"
var_os="debian"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
if [[ ! -f /etc/systemd/system/esphomeDashboard.service ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_info "Stopping Calibre-Web"
systemctl stop esphomeDashboard
msg_ok "Stopped Calibre-Web"

msg_info "Updating Calibre-Web"
if [[ -d /srv/esphome ]]; then
  source /srv/esphome/bin/activate &>/dev/null
fi
pip3 install -U esphome &>/dev/null
msg_ok "Updated Calibre-Web"

msg_info "Starting Calibre-Web"
systemctl start esphomeDashboard
msg_ok "Started Calibre-Web"
msg_ok "Updated Successfully"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following URL.
         ${BL}http://${IP}:8083${CL} \n"
