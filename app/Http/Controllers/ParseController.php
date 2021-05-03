<?php

namespace App\Http\Controllers;

use App\Models\Content;
use App\Models\Logs;

class ParseController extends Controller
{
    /**
     * Store new feed items.
     */
    public function store() {
        $url = 'http://static.feed.rbc.ru/rbc/logical/footer/news.rss';
        $rss = shell_exec('curl '.$url);
        $headers = shell_exec('curl -I '.$url.' | grep HTTP/1.1');
        $code = trim(str_replace('HTTP/1.1', '', $headers));
        $logs = new Logs();

        $logs->method = 'GET';
        $logs->url = $url;
        $logs->http_code = $code;

        if(!empty($rss) && trim($rss) != '') {
            $logs->body = $rss;
            $rss_obj = simplexml_load_string($rss, NULL, LIBXML_NOCDATA);
            $parsed_rss = json_decode(json_encode($rss_obj), TRUE);

            if(isset($parsed_rss['channel']) && isset($parsed_rss['channel']['item'])) {
                $fetcher = new Content();
                foreach($parsed_rss['channel']['item'] as $item) {
                    $content = new Content();
                    $title = $item['title'];
                    $link = $item['link'];
                    $description = $item['description'];
                    $guid = $item['guid'];
                    $author = isset($item['author']) ? $item['author'] : NULL;
                    $date_string = explode('+', $item['pubDate']);
                    $date = date('Y-m-d H:i:s', strtotime($date_string[0]));

                    $image = NULL;
                    if(isset($item['enclosure']) && isset($item['enclosure']['@attributes']) && isset($item['enclosure']['@attributes']['url'])) {
                        $image = $item['enclosure']['@attributes']['url'];
                    }
                    $existing_record = $fetcher->where('guid', '=', $guid)->get();

                    if(empty($existing_record)) {
                        $content->guid = $guid;
                        $content->title = $title;
                        $content->url = $link;
                        $content->short_description = $description;
                        $content->date_published = $date;
                        $content->author = $author;
                        $content->image = $image;
                        $content->created_at = date('Y-m-d H:i:s');

                        $content->save();
                    }
                }
            }
        } else {
            $logs->body = '';
        }

        $logs->save();
    }
}
