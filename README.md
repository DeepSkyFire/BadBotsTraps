# BadBotsTraps

Counterattacks against malicious scanners or bad bots.

Yeah, We need Counterattacks, not a passive defense.

# How to usage

1. Use `generate.sh` to generate new file, use `-h` to show how to generate.
2. Rename the resulting file. It is recommended to use random name (just like: md5( random() ).gzip ). 
3. Change the `$GzipFile` in `TrapsPage.php` to a renamed file name.
4. I suggest changing the `TrapsPage.php` file to a randomly named file as well.
5. Upload the `.gzip` and `.php` files to the your need set traps website folder.
6. Change you Nginx default `error_page` setting to `error_page 404 TrapsPage.php;`. (Apache: `errorDocument 404 /TrapsPage.php` in `.htaccess`)
7. Enjoying your life.
