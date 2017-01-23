راهنمای نصب ربات 
******************
sudo apt-get update; sudo apt-get upgrade -y --force-yes; sudo apt-get install screen; sudo apt-get install tmux; sudo apt-get dist-upgrade -y --force-yes; sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev lua-socket lua-sec lua-expat libevent-dev libjansson* libpython-dev make unzip git redis-server g++ autoconf -y --force-yes

cd $HOME && git clone https://github.com/boydevreza/fa.git && cd fa && chmod +x launch.sh && ./launch.sh install && ./launch.sh


cd .luarocks && cd bin && ./luarocks-5.2 install luafilesystem && ./luarocks-5.2 install lub && ./luarocks-5.2 install luaexpat && cd $HOME && cd fa && ./launch.sh install && ./launch.sh

+98......
******************
cd fa 
sed -i "s/root/$(whoami)/g" etc/pika.conf
sed -i "s_telegrambotpath_$(pwd)_g" etc/pika.conf
sudo cp etc/pika.conf /etc/init/
chmod 777 pika
nohup ./pika &>/dev/null &
sudo start pika
screen ./pika
-----------------
دستورات برای لانچ بات
cd fa
killall screen
killall tmux
killall telegram-cli
