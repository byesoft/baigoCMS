{function cate_list arr="" level=""}{* 栏目显示函数（递归） *}
    <ul class="list-unstyled{if $level > 0} list_padding{/if}">
        {foreach $arr as $key=>$value}
            <li>
                <dl class="dl_baigo">
                    <dt>{$value.cate_name}</dt>
                    <dd>
                        <label for="cate_{$value.cate_id}" class="checkbox-inline">
                            <input type="checkbox" id="cate_{$value.cate_id}" data-parent="chk_all">
                            {$lang.label.all}
                        </label>
                        {foreach $lang.allow as $key_s=>$value_s}
                            <label for="cate_{$value.cate_id}_{$key_s}" class="checkbox-inline">
                                <input type="checkbox" name="admin_allow_cate[{$value.cate_id}][{$key_s}]" value="1" id="cate_{$value.cate_id}_{$key_s}" data-parent="cate_{$value.cate_id}" {if isset($tplData.adminRow.admin_allow_cate[$value.cate_id][$key_s])}checked{/if}>
                                {$value_s}
                            </label>
                        {/foreach}
                    </dd>
                </dl>
                {if $value.cate_childs}
                    {cate_list arr=$value.cate_childs level=$value.cate_level}
                {/if}
            </li>
        {/foreach}
    </ul>
{/function}

{if $tplData.adminRow.admin_id < 1}
    {$title_sub    = $lang.page.add}
    {$sub_active   = "form"}
{else}
    {$title_sub    = $lang.page.edit}
    {$sub_active   = "list"}
{/if}

{$cfg = [
    title          => "{$adminMod.admin.main.title} - {$title_sub}",
    menu_active    => "admin",
    sub_active     => $sub_active,
    baigoCheckall  => "true",
    baigoValidator => "true",
    baigoSubmit    => "true",
    tokenReload    => "true",
    str_url        => "{$smarty.const.BG_URL_ADMIN}ctl.php?mod=admin"
]}

{include "{$smarty.const.BG_PATH_TPLSYS}admin/default/include/admin_head.tpl" cfg=$cfg}

    <li><a href="{$smarty.const.BG_URL_ADMIN}ctl.php?mod=admin&act_get=list">{$adminMod.admin.main.title}</a></li>
    <li>{$title_sub}</li>

    {include "{$smarty.const.BG_PATH_TPLSYS}admin/default/include/admin_left.tpl" cfg=$cfg}

    <div class="form-group">
        <ul class="nav nav-pills nav_baigo">
            <li>
                <a href="{$smarty.const.BG_URL_ADMIN}ctl.php?mod=admin&act_get=list">
                    <span class="glyphicon glyphicon-chevron-left"></span>
                    {$lang.href.back}
                </a>
            </li>
            <li>
                <a href="{$smarty.const.BG_URL_HELP}ctl.php?mod=admin&act_get=admin#form" target="_blank">
                    <span class="glyphicon glyphicon-question-sign"></span>
                    {$lang.href.help}
                </a>
            </li>
        </ul>
    </div>

    <form name="admin_form" id="admin_form" autocomplete="off">
        <input type="hidden" name="{$common.tokenRow.name_session}" value="{$common.tokenRow.token}">
        <input type="hidden" name="act_post" value="submit">
        <input type="hidden" name="admin_id" id="admin_id" value="{$tplData.adminRow.admin_id}">

        <div class="row">
            <div class="col-md-9">
                <div class="panel panel-default">
                    <div class="panel-body">
                        {if $tplData.adminRow.admin_id > 0}
                            <div class="form-group">
                                <label class="control-label">{$lang.label.username}</label>
                                <input type="text" name="admin_name" id="admin_name" class="form-control" readonly value="{$tplData.adminRow.ssoRow.user_name}">
                            </div>

                            <div class="form-group">
                                <div id="group_admin_pass">
                                    <label class="control-label">{$lang.label.password}</label>
                                    <input type="text" name="admin_pass" id="admin_pass" class="form-control" placeholder="{$lang.label.onlyModi}">
                                </div>
                            </div>
                        {else}
                            <div class="form-group">
                                <div id="group_admin_name">
                                    <label class="control-label">{$lang.label.username}<span id="msg_admin_name">*</span></label>
                                    <input type="text" name="admin_name" id="admin_name" data-validate class="form-control">
                                </div>
                            </div>

                            <div class="form-group">
                                <div id="group_admin_pass">
                                    <label class="control-label">{$lang.label.password}<span id="msg_admin_pass">*</span></label>
                                    <input type="text" name="admin_pass" id="admin_pass" data-validate class="form-control">
                                </div>
                            </div>
                        {/if}

                        <div class="form-group">
                            <div id="group_admin_mail">
                                <label class="control-label">{$lang.label.mail}<span id="msg_admin_mail"></span></label>
                                <input type="text" name="admin_mail" id="admin_mail" value="{$tplData.adminRow.ssoRow.user_mail}" data-validate class="form-control">
                            </div>
                        </div>

                        <div class="form-group">
                            <div id="group_admin_nick">
                                <label class="control-label">{$lang.label.nick}<span id="msg_admin_nick"></span></label>
                                <input type="text" name="admin_nick" id="admin_nick" value="{if $tplData.adminRow.admin_nick}{$tplData.adminRow.admin_nick}{else}{$tplData.adminRow.ssoRow.user_nick}{/if}" data-validate class="form-control">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label">{$lang.label.cateAllow}</label>
                            <div class="checkbox_baigo">
                                <label for="chk_all">
                                    <input type="checkbox" id="chk_all" data-parent="first">
                                    {$lang.label.all}
                                </label>
                            </div>
                            {cate_list arr=$tplData.cateRows}
                        </div>

                        <div class="form-group">
                            <div id="group_admin_note">
                                <label class="control-label">{$lang.label.note}<span id="msg_admin_note"></span></label>
                                <input type="text" name="admin_note" id="admin_note" value="{$tplData.adminRow.admin_note}" data-validate class="form-control">
                            </div>
                        </div>

                        <div class="form-group">
                            <button type="button" class="go_submit btn btn-primary">{$lang.btn.submit}</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="well">
                    {if $tplData.adminRow.admin_id > 0}
                        <div class="form-group">
                            <label class="control-label">{$lang.label.id}</label>
                            <p class="form-control-static">{$tplData.adminRow.admin_id}</p>
                        </div>
                    {/if}

                    <div class="form-group">
                        <div id="group_admin_type">
                            <label class="control-label">{$lang.label.type}<span id="msg_admin_type">*</span></label>
                            {foreach $type.admin as $key=>$value}
                                <div class="radio_baigo">
                                    <label for="admin_type_{$key}">
                                        <input type="radio" name="admin_type" id="admin_type_{$key}" value="{$key}" {if $tplData.adminRow.admin_type == $key}checked{/if} data-validate="admin_type">
                                        {$value}
                                    </label>
                                </div>
                            {/foreach}
                        </div>
                    </div>

                    <div class="form-group">
                        <div id="group_admin_status">
                            <label class="control-label">{$lang.label.status}<span id="msg_admin_status">*</span></label>
                            {foreach $status.admin as $key=>$value}
                                <div class="radio_baigo">
                                    <label for="admin_status_{$key}">
                                        <input type="radio" name="admin_status" id="admin_status_{$key}" value="{$key}" {if $tplData.adminRow.admin_status == $key}checked{/if} data-validate="admin_status">
                                        {$value}
                                    </label>
                                </div>
                            {/foreach}
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label">{$lang.label.profileAllow}</label>
                        <div class="checkbox_baigo">
                            <label for="admin_allow_profile_info">
                                <input type="checkbox" name="admin_allow_profile[info]" id="admin_allow_profile_info" value="1" {if isset($tplData.adminRow.admin_allow_profile.info) && $tplData.adminRow.admin_allow_profile.info == "1"}checked{/if}>
                                {$lang.label.profileInfo}
                            </label>
                        </div>
                        <div class="checkbox_baigo">
                            <label for="admin_allow_profile_pass">
                                <input type="checkbox" name="admin_allow_profile[pass]" id="admin_allow_profile_pass" value="1" {if isset($tplData.adminRow.admin_allow_profile.pass) && $tplData.adminRow.admin_allow_profile.pass == "1"}checked{/if}>
                                {$lang.label.profilePass}
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>

{include "{$smarty.const.BG_PATH_TPLSYS}admin/default/include/admin_foot.tpl" cfg=$cfg}

    <script type="text/javascript">
    var opts_validator_form = {
        admin_name: {
            len: { min: 1, max: 0 },
            validate: { type: "ajax", format: "strDigit", group: "#group_admin_name" },
            msg: { selector: "#msg_admin_name", too_short: "{$alert.x020201}", too_long: "{$alert.x020202}", format_err: "{$alert.x020203}", ajaxIng: "{$alert.x030401}", ajax_err: "{$alert.x030402}" },
            ajax: { url: "{$smarty.const.BG_URL_ADMIN}ajax.php?mod=admin&act_get=chkname", key: "admin_name", type: "str" }
        },
        admin_pass: {
            len: { min: 1, max: 0 },
            validate: { type: "str", format: "text", group: "#group_admin_pass" },
            msg: { selector: "#msg_admin_pass", too_short: "{$alert.x020210}" }
        },
        admin_mail: {
            len: { min: 0, max: 0 },
            validate: { type: "ajax", format: "email", group: "#group_admin_mail" },
            msg: { selector: "#msg_admin_mail", too_short: "{$alert.x020207}", too_long: "{$alert.x020208}", format_err: "{$alert.x020209}", ajaxIng: "{$alert.x030401}", ajax_err: "{$alert.x030402}" },
            ajax: { url: "{$smarty.const.BG_URL_ADMIN}ajax.php?mod=admin&act_get=chkmail", key: "admin_mail", type: "str", attach_selectors: ["#admin_id"], attach_keys: ["admin_id"] }
        },
        admin_nick: {
            len: { min: 0, max: 30 },
            validate: { type: "str", format: "text", group: "#group_admin_nick" },
            msg: { selector: "#msg_admin_nick", too_long: "{$alert.x020216}" }
        },
        admin_note: {
            len: { min: 0, max: 30 },
            validate: { type: "str", format: "text", group: "#group_admin_note" },
            msg: { selector: "#msg_admin_note", too_long: "{$alert.x020212}" }
        },
        admin_type: {
            len: { min: 1, max: 0 },
            validate: { selector: "input[name='admin_type']", type: "radio", group: "#group_admin_type" },
            msg: { selector: "#msg_admin_type", too_few: "{$alert.x020219}" }
        },
        admin_status: {
            len: { min: 1, max: 0 },
            validate: { selector: "input[name='admin_status']", type: "radio", group: "#group_admin_status" },
            msg: { selector: "#msg_admin_status", too_few: "{$alert.x020213}" }
        }
    };

    var opts_submit_form = {
        ajax_url: "{$smarty.const.BG_URL_ADMIN}ajax.php?mod=admin",
        text_submitting: "{$lang.label.submitting}",
        btn_text: "{$lang.btn.ok}",
        btn_close: "{$lang.btn.close}",
        btn_url: "{$cfg.str_url}"
    };

    $(document).ready(function(){
        var obj_validate_form = $("#admin_form").baigoValidator(opts_validator_form);
        var obj_submit_form   = $("#admin_form").baigoSubmit(opts_submit_form);
        $(".go_submit").click(function(){
            if (obj_validate_form.verify()) {
                obj_submit_form.formSubmit();
            }
        });
        $("#admin_form").baigoCheckall();
    });
    </script>

{include "{$smarty.const.BG_PATH_TPLSYS}admin/default/include/html_foot.tpl" cfg=$cfg}