#!/usr/local/bin/php -q
<?php

# author: the-razer on nas4free.org forums
# last update: 13.09.12
#
# check for firmware updates and
# send a mail when a newer version
# is found (will resend when machine
# gets rebooted)

//require("auth.inc");
require("guiconfig.inc");

$locale = $config['system']['language'];

function check_firmware_version($locale) {
        global $g;

        $post = "product=".rawurlencode(get_product_name())
              . "&platform=".rawurlencode($g['fullplatform'])
              . "&version=".rawurlencode(get_product_version())
              . "&revision=".rawurlencode(get_product_revision());
        $url = trim(get_firm_url());
        if (preg_match('/^([^\/]+)(\/.*)/', $url, $m)) {
                $host = $m[1];
                $path = $m[2];
        } else {
                $host = $url;
                $path = "";
        }

        $rfd = @fsockopen($host, 80, $errno, $errstr, 3);
        if ($rfd) {
                $hdr = "POST $path/checkversion.php?locale=$locale HTTP/1.0\r\n";
                $hdr .= "Content-Type: application/x-www-form-urlencoded\r\n";
                $hdr .= "User-Agent: ".get_product_name()."-webGUI/1.0\r\n";
                $hdr .= "Host: ".$host."\r\n";
                $hdr .= "Content-Length: ".strlen($post)."\r\n\r\n";

                fwrite($rfd, $hdr);
                fwrite($rfd, $post);

                $inhdr = true;
                $resp = "";
                while (!feof($rfd)) {
                        $line = fgets($rfd);
                        if ($inhdr) {
                                if (trim($line) === "")
                                        $inhdr = false;
                        } else {
                                $resp .= $line;
                        }
                }

                fclose($rfd);

                return $resp;
        }

        return null;
}


function get_path_version($rss) {
        $version = get_product_version();

        $resp = "$version";
        // e.g. version = 9.1.0.1 -> 9001, 0001
        if (preg_match("/^.*(\d+)\.(\d+)\.(\d)\.(\d).*$/", $version, $m)) {
                $os_ver = $m[1] * 1000 + $m[2];
                $pd_ver = $m[3] * 1000 + $m[4];
        } else {
                return $resp;
        }

        $xml = @simplexml_load_file($rss);
        if (empty($xml)) return $resp;
        foreach ($xml->channel->item as $item) {
                $title = $item->title;
                $parts = pathinfo($title);
                if ($parts['dirname'] === "/") {
                        if (preg_match("/^.*(\d+)\.(\d+)\.(\d)\.(\d).*$/",
                            $parts['basename'], $m)) {
                                $os_ver2 = $m[1] * 1000 + $m[2];
                                $pd_ver2 = $m[3] * 1000 + $m[4];
                                $rss_version = sprintf("%d.%d.%d.%d",
                                    $m[1], $m[2], $m[3], $m[4]);
                                // Compare with rss version, equal or greater?
                                if ($os_ver2 > $os_ver
                                    || ($os_ver2 == $os_ver && $pd_ver2 >= $pd_ver)) {
                                    $resp = $rss_version;
                                    break;
                                }
                        }
                }
        }
        return $resp;
}

function get_latest_file($rss) {
        global $g;
        $product = get_product_name();
        $platform = $g['fullplatform'];
        $version = get_product_version();
        $revision = get_product_revision();
        if (preg_match("/^(.*?)(\d+)$/", $revision, $m)) {
                $revision = $m[2];
        }
        $ext = "img";

        $resp = "";
        $xml = @simplexml_load_file($rss);
        if (empty($xml)) return $resp;
        foreach ($xml->channel->item as $item) {
                $link = $item->link;
                $title = $item->title;
                $date = $item->pubDate;
                $parts = pathinfo($title);
                if (empty($parts['extension']) || strcasecmp($parts['extension'], $ext) != 0)
                        continue;
                $filename = $parts['filename'];
                $fullname = $parts['filename'].".".$parts['extension'];

                if (preg_match("/^{$product}-{$platform}-(.*?)\.(\d+)$/", $filename, $m)) {
                        $filever = $m[1];
                        $filerev = $m[2];
                        if ($version < $filever
                            || ($version == $filever && $revision < $filerev)) {
                                //$resp .= sprintf("<a href=\"%s\" title=\"%s\" target=\"_blank\">%s</a> (%s)",
                                //        htmlspecialchars($link), htmlspecialchars($title),
                                //        htmlspecialchars($fullname), htmlspecialchars($date));
                                $resp = $fullname."\n".$link;
                        } else {
                                $resp .= sprintf("%s (%s)", htmlspecialchars($fullname),
                                        htmlspecialchars($date));
                        }
                        break;
                }
        }
        return $resp;
}

function check_firmware_version_rss($locale) {
        $rss_path = "http://sourceforge.net/api/file/index/project-id/722987/mtime/desc/limit/20/rss";
        $rss_release = "http://sourceforge.net/api/file/index/project-id/722987/path/NAS4Free-@@VERSION@@/mtime/desc/limit/20/rss";
        $rss_beta = "http://sourceforge.net/api/file/index/project-id/722987/path/NAS4Free-Beta/mtime/desc/limit/20/rss";

        // replace with existing version
        $path_version = get_path_version($rss_path);
        if (empty($path_version)) {
                return "";
        }
        $rss_release = str_replace('@@VERSION@@', $path_version, $rss_release);

        $release = get_latest_file($rss_release);
        $beta = get_latest_file($rss_beta);
        return $release;
        $resp = "";
        if (!empty($release)) {
                $resp .= sprintf(gettext("Latest Release: %s"), $release);
                $resp .= "<br />\n";
        }
        if (!empty($beta)) {
                $resp .= sprintf(gettext("Latest Beta Build: %s"), $beta);
                $resp .= "<br />\n";
        }
        return $resp;
}



$fwinfo = check_firmware_version_rss($locale);
echo $fwinfo;



?>
