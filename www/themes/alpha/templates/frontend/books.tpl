{if {$site->adbrowse} != ''}
    <div class="container" style="width:500px;">
        <fieldset class="adbanner div-center">
            <legend class="adbanner">Advertisement</legend>
            {$site->adbrowse}
        </fieldset>
    </div>
    <br>
{/if}

<div class="panel">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#searchtoggle">
                <i class="icon-search"></i> Search Filter</a>
            </a>
        </h4>
    </div>
    <div id="searchtoggle" class="panel-collapse collapse">
        <div class="panel-body">
            {include file='search-filter.tpl'}
        </div>
    </div>
</div>

{if $results|@count > 0}
    <form id="nzb_multi_operations_form" action="get">
        <div class="container nzb_multi_operations" style="text-align:right;margin-bottom:5px;">
            View:
            <span><i class="icon-th-list"></i></span>&nbsp;&nbsp;
            <a href="{$smarty.const.WWW_TOP}/browse?t={$category}"><i class="icon-align-justify"></i></a>
            {if $isadmin || $ismod}
                &nbsp;&nbsp;
                Admin:
                <input type="button" class="btn btn-warning nzb_multi_operations_edit" value="Edit">
                <input type="button" class="btn btn-danger nzb_multi_operations_delete" value="Delete">
            {/if}
        </div>
        {include file='multi-operations.tpl'}



        <table class="table table-condensed table-striped data" id="coverstable">
            <thead>
            <tr>
                <th><input type="checkbox" class="nzb_check_all"></th>
                <th>author <a title="Sort Descending" href="{$orderbyauthor_desc}"><i class="icon-chevron-down"></i></a><a
                            title="Sort Ascending" href="{$orderbyauthor_asc}"><i class="icon-chevron-up"></i></a></th>
                <th>genre <a title="Sort Descending" href="{$orderbygenre_desc}"><i class="icon-chevron-down"></i></a><a
                            title="Sort Ascending" href="{$orderbygenre_asc}"><i class="icon-chevron-up"></i></a></th>
                <th>posted <a title="Sort Descending" href="{$orderbyposted_desc}"><i class="icon-chevron-down"></i></a><a
                            title="Sort Ascending" href="{$orderbyposted_asc}"><i class="icon-chevron-up"></i></a></th>
            </tr>
            </thead>
            <tbody>
            {foreach from=$results item=result}
                <tr>
                    <td style="text-align:center;width:150px;padding:10px;">
                        <div class="bookcover">
                            <a class="title thumbnail" title="View amazon page" href="{$site->dereferrer_link}{$result.url}">
                                <img class="shadow"
                                     src="{$smarty.const.WWW_TOP}/covers/book/{if $result.cover == 1}{$result.bookinfoid}.jpg{else}no-cover.jpg{/if}"
                                     width="120" border="0" alt="{$result.title|escape:"htmlall"}">
                            </a>

                            <div class="relextra" style="margin-top:5px;">
                                {if $result.nfoid > 0}<a href="{$smarty.const.WWW_TOP}/nfo/{$result.guid}"
                                                         title="View Nfo" class="label modal_nfo" rel="nfo">
                                        Nfo</a> {/if}
                                <a class="label" target="_blank" href="{$site->dereferrer_link}{$result.url}"
                                   name="amazon{$result.bookinfoid}" title="View amazon page">Amazon</a>
                                <a class="label" href="{$smarty.const.WWW_TOP}/browse?g={$result.group_name}"
                                   title="Browse releases in {$result.group_name|replace:"alt.binaries":"a.b"}">Grp</a>
                            </div>
                        </div>
                    </td>
                    <td colspan="8" class="left" id="guid{$result.guid}">
                        <h4>{$result.author}{" - "}{$result.title}
                        </h4>
                        {if $result.genre != "null"}<b>Genre:</b>{$result.genre|escape:'htmlall'}<br>{/if}
                        {if $result.publisher != ""}<b>Publisher:</b>{$result.publisher}<br>{/if}
                        {if $result.publishdate != ""}<b>Released:</b>{$result.publishdate|date_format}<br>{/if}
                        {if $result.pages != ""}<b>Pages:</b>{$result.pages}<br>{/if}
                        {if $result.salesrank != ""}<b>Amazon Rank:</b>{$result.salesrank}<br>{/if}
                        {if $result.overview != "null"}<b>Overview:</b>{$result.overview|escape:'htmlall'}<br>{/if}
                        <br>

                        <div class="relextra">
                            <table class="table table-condensed table-hover data">
                                {assign var="bsplits" value=","|explode:$result.grp_release_id}
                                {assign var="bguid" value=","|explode:$result.grp_release_guid}
                                {assign var="bnfo" value=","|explode:$result.grp_release_nfoid}
                                {assign var="bgrp" value=","|explode:$result.grp_release_grpname}
                                {assign var="bname" value="#"|explode:$result.grp_release_name}
                                {assign var="bpostdate" value=","|explode:$result.grp_release_postdate}
                                {assign var="bsize" value=","|explode:$result.grp_release_size}
                                {assign var="btotalparts" value=","|explode:$result.grp_release_totalparts}
                                {assign var="bcomments" value=","|explode:$result.grp_release_comments}
                                {assign var="bgrabs" value=","|explode:$result.grp_release_grabs}
                                {assign var="bpass" value=","|explode:$result.grp_release_password}
                                {assign var="binnerfiles" value=","|explode:$result.grp_rarinnerfilecount}
                                {assign var="bhaspreview" value=","|explode:$result.grp_haspreview}
                                <tbody>
                                {foreach from=$bsplits item=b}
                                    <tr id="guid{$bguid[$b@index]}" {if $b@index > 1}class="relextra"{/if}>
                                        <td style="width: 27px;">
                                            <input type="checkbox" class="nzb_check" value="{$bguid[$b@index]}">
                                        </td>
                                        <td class="name">
                                            <a href="{$smarty.const.WWW_TOP}/details/{$bguid[$b@index]}/{$bname[$b@index]|escape:"htmlall"}"><b>{$bname[$b@index]|escape:"htmlall"}</b></a><br>

                                            <div class="container">
                                                <div class="pull-left"><i class="icon-calendar"></i>
                                                    Posted {$bpostdate[$b@index]|timeago} | <i
                                                            class="icon-hdd"></i> {$bsize[$b@index]|fsize_format:"MB"} |
                                                    <i class="icon-file"></i> <a title="View file list"
                                                                                 href="{$smarty.const.WWW_TOP}/filelist/{$bguid[$b@index]}">{$btotalparts[$b@index]}
                                                        files</a> | <i class="icon-comments"></i> <a
                                                            title="View comments for {$bname[$b@index]|escape:"htmlall"}"
                                                            href="{$smarty.const.WWW_TOP}/details/{$bguid[$b@index]}/{$bname[$b@index]|escape:"htmlall"}#comments">{$bcomments[$b@index]}
                                                        cmt{if $bcomments[$b@index] != 1}s{/if}</a> | <i
                                                            class="icon-download"></i> {$bgrabs[$b@index]}
                                                    grab{if $bgrabs[$b@index] != 1}s{/if}
                                                </div>
                                                <div class="pull-right">
                                                    {if $bnfo[$b@index] > 0}<span class="label label-default"><a
                                                                href="{$smarty.const.WWW_TOP}/nfo/{$bguid[$b@index]}"
                                                                title="View Nfo" class="modal_nfo" rel="nfo">Nfo</a>
                                                        </span> {/if}
                                                    {if $bpass[$b@index] == 1}
                                                        <span class="label label-default">Passworded</span>
                                                    {elseif $bpass[$b@index] == 2}
                                                        <span class="label label-default">Potential Password</span>
                                                    {/if}
                                                    <span class="label label-default"><a
                                                                href="{$smarty.const.WWW_TOP}/browse?g={$bgrp[$b@index]}"
                                                                title="Browse releases in {$bgrp[$b@index]|replace:"alt.binaries":"a.b"}">Grp</a></span>
                                                    {if $bhaspreview[$b@index] == 1 && $userdata.canpreview == 1}<span
                                                            class="label label-default"><a
                                                                href="{$smarty.const.WWW_TOP}/covers/preview/{$bguid[$b@index]}_thumb.jpg"
                                                                name="name{$bguid[$b@index]}"
                                                                title="Screenshot of {$bname[$b@index]|escape:"htmlall"}"
                                                                class="modal_prev" rel="preview">Preview</a>
                                                        </span> {/if}
                                                    {if $binnerfiles[$b@index] > 0}<span class="label label-default"><a
                                                                href="#" onclick="return false;" class="mediainfo"
                                                                title="{$bguid[$b@index]}">Media</a></span> {/if}
                                                </div>
                                            </div>
                                        </td>
                                        <td class="icons" style="width:90px;">
                                            <div class="icon icon_nzb float-right"><a title="Download Nzb"
                                                                                      href="{$smarty.const.WWW_TOP}/getnzb/{$bguid[$b@index]}/{$bname[$b@index]|escape:"htmlall"}"></a>
                                            </div>
                                            {if $sabintegrated}
                                                <div class="icon icon_sab float-right" title="Send to my Sabnzbd"></div>
                                            {/if}
                                            <div class="icon icon_cart float-right" title="Add to Cart"></div>
                                            <br>
                                            {*s{if $isadmin || $ismod}
                                            <a class="label label-warning" href="{$smarty.const.WWW_TOP}/admin/release-edit.php?id={$result.id}&amp;from={$smarty.server.REQUEST_URI|escape:"url"}" title="Edit Release">Edit</a>
                                            <a class="label confirm_action label-danger" href="{$smarty.const.WWW_TOP}/admin/release-delete.php?id={$result.id}&amp;from={$smarty.server.REQUEST_URI|escape:"url"}" title="Delete Release">Delete</a>
                                            {/if}*}
                                        </td>
                                    </tr>
                                    {if $b@index == 1 && $b@total > 2}
                                        <tr>
                                            <td colspan="5"><a class="mlmore" href="#">{$b@total-2} more...</a></td>
                                        </tr>
                                    {/if}
                                {/foreach}
                                </tbody>
                            </table>
                        </div>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>


        {if $results|@count > 10}
            <div class="nzb_multi_operations">
                {include file='multi-operations.tpl'}
            </div>
        {/if}
    </form>
{else}
    <div class="alert">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <strong>Sorry!</strong> Either some amazon key is wrong, or there is nothing in this section.
    </div>
{/if}
