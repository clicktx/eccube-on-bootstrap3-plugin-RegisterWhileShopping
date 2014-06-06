<?php
/*
 * MultipleCart
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


class plugin_info{
    static $PLUGIN_CODE         = "RegisterWhileShopping";      // プラグインコード
    static $PLUGIN_NAME         = "注文完了画面でも会員登録";   // プラグイン名
    static $PLUGIN_VERSION      = "1.0.1";                      // プラグインバージョン
    static $COMPLIANT_VERSION   = "2.12～2.13系";                     // 対応バージョン
    static $AUTHOR              = "株式会社サンアットマーク";   // プラグイン作者
    static $DESCRIPTION         = "購入手続き中に、付加情報を入力することにより注文と同時に会員登録ができます。これにより、非会員や一見客の会員登録率がアップします。"; // プラグインの説明
    static $PLUGIN_SITE_URL     = "http://www.sunatmark.co.jp/";// プラグインURL
    static $AUTHOR_SITE_URL     = "http://www.sunatmark.co.jp/";// プラグイン作者URL
    static $CLASS_NAME          = "RegisterWhileShopping";      // プラグインクラス名
    static $HOOK_POINTS         = array(                        // フックポイントとコールバック関数
        array("prefilterTransform", "prefilterTransform"),
        array("LC_Page_preProcess", "pagePreProcess"),
        array("LC_Page_Shopping_Confirm_action_before", "shoppingConfirmActionBefore"),
        array("LC_Page_Shopping_Complete_action_before", "shoppingCompleteActionBefore")
    );
    static $LICENSE             = "LGPL";                       // ライセンス
}

?>
