# docker-dgui

## usages

see docker-compose.yml


## Homefolder
mount dir with one or more homefolder. 
Create a file ".myuser" per user with prehashed password. 
mkpasswd -m sha-512

### Content of .myuser
pass='{prehased password}'
uid={userid}
gid={groupid}
groups="group1 group2 group3"


echo "xfce4-session" > ~/.xsession

???
to start chromium in gui-session, set an alias in .bashrc  

alias chromium-browser='chromium-browser --no-sandbox'  
