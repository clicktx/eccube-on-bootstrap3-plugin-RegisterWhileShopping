<!--{*
/*
 * RegisterWhileShopping
 * Copyright (C) 2012 SUNATMARK CO.,LTD. All Rights Reserved.
 * http://www.sunatmark.co.jp/
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
*}-->

<!--{strip}-->

<!--{if not $plg_RegisterWhileShopping_tpl_login}-->
<!--{if not $plg_RegisterWhileShopping_email_registered}-->

<div class="alert alert-info">
    下記をご記入いただくだけで、注文完了と同時に会員登録ができます。会員登録せずにご購入いただく場合は、下記に何も記入せずにお進みください。
</div>
<!--{if $plg_RegisterWhileShopping_arrErr.email}-->
    <div class="attention">
        <!--{$plg_RegisterWhileShopping_arrErr.email}-->
    </div>
<!--{/if}-->
<input type="hidden" name="name01" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_name01}-->" />
<input type="hidden" name="name02" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_name02}-->" />
<input type="hidden" name="kana01" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_kana01}-->" />
<input type="hidden" name="kana02" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_kana02}-->" />
<input type="hidden" name="zip01" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_zip01}-->" />
<input type="hidden" name="zip02" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_zip02}-->" />
<input type="hidden" name="pref" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_pref}-->" />
<input type="hidden" name="addr01" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_addr01}-->" />
<input type="hidden" name="addr02" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_addr02}-->" />
<input type="hidden" name="tel01" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_tel01}-->" />
<input type="hidden" name="tel02" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_tel02}-->" />
<input type="hidden" name="tel03" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_tel03}-->" />
<input type="hidden" name="fax01" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_fax01}-->" />
<input type="hidden" name="fax02" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_fax02}-->" />
<input type="hidden" name="fax03" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_fax03}-->" />
<input type="hidden" name="sex" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_sex}-->" />
<input type="hidden" name="job" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_job}-->" />
<input type="hidden" name="year" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_year}-->" />
<input type="hidden" name="month" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_month}-->" />
<input type="hidden" name="day" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_day}-->" />
<input type="hidden" name="email" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_email}-->" />
<input type="hidden" name="email02" value="<!--{$plg_RegisterWhileShopping_arrOrder.order_email}-->" />
<div class="jumbotron">
    <div class="row form-horizontal">
        <div class="form-group">
            <label for="password" class="col-md-5 control-label">
                希望するパスワード（記号可）<span class="attention">※</span>
            </label>
            <div class="col-md-7">
                <div class="form-group">
                    <div class="col-md-10<!--{if $plg_RegisterWhileShopping_arrErr.password}--> has-error<!--{/if}-->">
                        <input type="password" id="password" class="box380 top form-control" name="password" value="<!--{$plg_RegisterWhileShopping_arrFrom.password|h}-->" maxlength="<!--{$smarty.const.PASSWORD_MAX_LEN}-->" style="<!--{$plg_RegisterWhileShopping_arrErr.password|sfGetErrorColor}-->" placeholder="半角英数字<!--{$smarty.const.PASSWORD_MIN_LEN}-->～<!--{$smarty.const.PASSWORD_MAX_LEN}-->文字" />
                        <!--{if $plg_RegisterWhileShopping_arrErr.password}-->
                            <span class="attention"><!--{$plg_RegisterWhileShopping_arrErr.password}--></span>
                        <!--{/if}-->
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-10<!--{if $plg_RegisterWhileShopping_arrErr.password02}--> has-error<!--{/if}-->">
                        <input type="password" class="box380 form-control" name="password02" value="<!--{$plg_RegisterWhileShopping_arrFrom.password02|h}-->" maxlength="<!--{$smarty.const.PASSWORD_MAX_LEN}-->" style="<!--{$plg_RegisterWhileShopping_arrErr.password|cat:$plg_RegisterWhileShopping_arrErr.password02|sfGetErrorColor}-->" placeholder="パスワード確認用" />
                        <!--{if $plg_RegisterWhileShopping_arrErr.password02}-->
                            <span class="attention"><!--{$plg_RegisterWhileShopping_arrErr.password02}--></span>
                        <!--{/if}-->
                        <div class="mini help-block"><span class="attention">確認のため2度入力してください。</span></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label for="reminder" class="col-md-5 control-label">
                パスワードを忘れた時のヒント<span class="attention">※</span>
            </label>
            <div class="col-md-7">
                <div class="form-group">
                    <div class="col-md-12<!--{if $plg_RegisterWhileShopping_arrErr.reminder}--> has-error<!--{/if}-->">
                        <select id="reminder" class="form-control" name="reminder" style="<!--{$plg_RegisterWhileShopping_arrErr.reminder|sfGetErrorColor}-->">
                            <option value="" selected="selected">質問を選択してください</option>
                            <!--{html_options options=$arrReminder selected=$plg_RegisterWhileShopping_arrFrom.reminder}-->
                        </select>
                        <!--{if $plg_RegisterWhileShopping_arrErr.reminder}-->
                            <span class="attention"><!--{$plg_RegisterWhileShopping_arrErr.reminder}--></span>
                        <!--{/if}-->
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-10<!--{if $plg_RegisterWhileShopping_arrErr.reminder_answer}--> has-error<!--{/if}-->">
                        <input type="text" class="box380 form-control" name="reminder_answer" value="<!--{$plg_RegisterWhileShopping_arrFrom.reminder_answer|h}-->" style="<!--{$plg_RegisterWhileShopping_arrErr.reminder_answer|sfGetErrorColor}-->; ime-mode: active;" placeholder="質問の答え" />
                        <!--{if $plg_RegisterWhileShopping_arrErr.reminder_answer}-->
                            <span class="attention"><!--{$plg_RegisterWhileShopping_arrErr.reminder_answer}--></span>
                        <!--{/if}-->
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-5 control-label">
                メールマガジン送付について<span class="attention">※</span>
            </label>
            <div class="col-md-7">
                <div class="form-group">
                    <div class="col-xs-12<!--{if $plg_RegisterWhileShopping_arrErr.mailmaga_flg}--> has-error<!--{/if}-->">
                        <div style="<!--{$plg_RegisterWhileShopping_arrErr.mailmaga_flg|sfGetErrorColor}-->">
                            <!--{html_radios name=mailmaga_flg options=$arrMAILMAGATYPE selected=$plg_RegisterWhileShopping_arrFrom.mailmaga_flg.value assign=mailmagatype}-->
                            <!--{foreach from=$mailmagatype item=radio}-->
                                <div class="radio">
                                    <label>
                                        <!--{$radio}-->
                                    </label>
                                </div>
                            <!--{/foreach}-->
                        </div>
                        <!--{if $plg_RegisterWhileShopping_arrErr.mailmaga_flg}-->
                            <span class="attention"><!--{$plg_RegisterWhileShopping_arrErr.mailmaga_flg}--></span>
                        <!--{/if}-->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--{else}-->
    <!--{if $plg_RegisterWhileShopping_arrErr.email}-->
        <div class="attention">
            <!--{$plg_RegisterWhileShopping_arrErr.email}-->
        </div>
    <!--{/if}-->
<!--{/if}-->
<!--{/if}-->

<!--{/strip}-->