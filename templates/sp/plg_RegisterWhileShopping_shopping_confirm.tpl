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

<section class="customerConfirmArea">
    <h3 class="subtitle">会員登録</h3>
<!--{if not $plg_RegisterWhileShopping_email_registered}-->
    <div class="form_area">
        下記をご記入いただくだけで、注文完了と同時に会員登録ができます。<br />
        会員登録せずにご購入いただく場合は、下記に何も記入せずにお進みください。
        <!--{if $plg_RegisterWhileShopping_arrErr.email}-->
        <div class="attention">
            <!--{$plg_RegisterWhileShopping_arrErr.email}-->
        </div>
        <!--{/if}-->
        <div class="formBox">
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
            <dl class="deliv_confirm">
                <dt>希望するパスワード<span class="attention">※</span></dt>
                <dd>
                    <!--{if $plg_RegisterWhileShopping_arrErr.password || $plg_RegisterWhileShopping_arrErr.password02}-->
                        <div class="attention"><!--{$plg_RegisterWhileShopping_arrErr.password}--><!--{$plg_RegisterWhileShopping_arrErr.password02}--></div>
                    <!--{/if}-->
                    <input type="password" name="password" value="<!--{$plg_RegisterWhileShopping_arrFrom.password|h}-->" maxlength="<!--{$smarty.const.PASSWORD_MAX_LEN}-->" style="<!--{$plg_RegisterWhileShopping_arrErr.password|sfGetErrorColor}-->" class="box120" />
                    <p><span class="attention mini">半角英数字<!--{$smarty.const.PASSWORD_MIN_LEN}-->～<!--{$smarty.const.PASSWORD_MAX_LEN}-->文字でお願いします。（記号不可）</span></p>
                    <input type="password" name="password02" value="<!--{$plg_RegisterWhileShopping_arrFrom.password02|h}-->" maxlength="<!--{$smarty.const.PASSWORD_MAX_LEN}-->" style="<!--{$plg_RegisterWhileShopping_arrErr.password|cat:$plg_RegisterWhileShopping_arrErr.password02|sfGetErrorColor}-->" class="box120" />
                    <p><span class="attention mini">確認のために2度入力してください。</span></p>
                </dd>
                <dt>パスワードを忘れた時のヒント<span class="attention">※</span></dt>
                <dd>
                    <!--{if $plg_RegisterWhileShopping_arrErr.reminder || $plg_RegisterWhileShopping_arrErr.reminder_answer}-->
                        <div class="attention"><!--{$plg_RegisterWhileShopping_arrErr.reminder}--><!--{$plg_RegisterWhileShopping_arrErr.reminder_answer}--></div>
                    <!--{/if}-->
                    質問：
                    <select name="reminder" style="<!--{$plg_RegisterWhileShopping_arrErr.reminder|sfGetErrorColor}-->">
                        <option value="" selected="selected">選択してください</option>
                        <!--{html_options options=$arrReminder selected=$plg_RegisterWhileShopping_arrFrom.reminder}-->
                    </select>
                    <br />
                    答え：<input type="text" name="reminder_answer" value="<!--{$plg_RegisterWhileShopping_arrFrom.reminder_answer|h}-->" style="<!--{$plg_RegisterWhileShopping_arrErr.reminder_answer|sfGetErrorColor}-->; ime-mode: active;" class="box260" />
                </dd>
                <dt>メールマガジン送付について<span class="attention">※</span></dt>
                <dd>
                    <!--{if $plg_RegisterWhileShopping_arrErr.mailmaga_flg}-->
                        <div class="attention"><!--{$plg_RegisterWhileShopping_arrErr.mailmaga_flg}--></div>
                    <!--{/if}-->
                    <span style="<!--{$plg_RegisterWhileShopping_arrErr.mailmaga_flg|sfGetErrorColor}-->">
                        <input type="radio" name="mailmaga_flg" value="1" id="html" <!--{if $plg_RegisterWhileShopping_arrFrom.mailmaga_flg eq 1}--> checked="checked" <!--{/if}--> /><label for="html">HTMLメール＋テキストメールを受け取る</label><br />
                        <input type="radio" name="mailmaga_flg" value="2" id="text" <!--{if $plg_RegisterWhileShopping_arrFrom.mailmaga_flg eq 2}--> checked="checked" <!--{/if}--> /><label for="text">テキストメールを受け取る</label><br />
                        <input type="radio" name="mailmaga_flg" value="3" id="no" <!--{if $plg_RegisterWhileShopping_arrFrom.mailmaga_flg eq 3}--> checked="checked" <!--{/if}--> /><label for="no">受け取らない</label>
                    </span>
                </dd>
            </dl>
        </div>
    </div>
<!--{else}-->
    <!--{if $plg_RegisterWhileShopping_arrErr.email}-->
        <div class="attention">
            <!--{$plg_RegisterWhileShopping_arrErr.email}-->
        </div>
    <!--{/if}-->
<!--{/if}-->
</section>

<!--{/if}-->

<!--{/strip}-->