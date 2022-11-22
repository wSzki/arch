ufw status | grep -e "inactive"
if [ "$?" = "1" ]; then
	echo yes > /home/wsz/.dot/var/ufw ;
else
	echo no > /home/wsz/.dot/var/ufw;
fi
