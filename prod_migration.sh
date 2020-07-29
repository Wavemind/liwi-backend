echo "========================================================"

dokku maintenance:on medalc
dokku maintenance:on liwi-test
echo "Maintenance enable"

dokku postgres:unlink liwi-test
dokku postgres:destroy liwi-test
dokku postgres:clone medalc liwi-test
dokku postgres:link liwi-test liwi-test
echo "Clone finish"

dokku run liwi-test rake users:seed_clinicians
echo "Seeds done"

dokku maintenance:off medalc
dokku maintenance:off liwi-test
echo "Maintenance disable"

echo "Finish"
