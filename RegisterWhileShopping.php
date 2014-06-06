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


class RegisterWhileShopping extends SC_Plugin_Base {

    protected $template_dir;
    protected $arrSession;

    /**
     * コンストラクタ
     *
     * @param array $arrPlugin プラグイン情報
     * @return void
     */
    public function __construct(array $arrPlugin) {
        parent::__construct($arrPlugin);
        $this->template_dir = PLUGIN_UPLOAD_REALDIR . $arrPlugin['plugin_code'] . '/templates/';
    }

    /**
     * インストール
     * (プラグインのインストール時に実行)
     *
     * @param array $arrPlugin プラグイン情報
     * @return void
     */
    function install($arrPlugin) {
        $objQuery = SC_Query_Ex::getSingletonInstance();

        // メディアファイルコピー
		$cp_result = SC_Utils_Ex::sfCopyDir(PLUGIN_UPLOAD_REALDIR . $arrPlugin['plugin_code'] . '/front/', PLUGIN_HTML_REALDIR . $arrPlugin['plugin_code'] . '/');
        if ($cp_result === false) {
            $cp_fail = true;
        }
		else {
            if (preg_match('/失敗/us', $cp_result)) $cp_fail = true;
        }
        if (isset($cp_fail)) {
            $objQuery->delete('dtb_plugin', 'plugin_code = ?', array(get_class()));
            SC_Utils_Ex::sfDispSiteError(FREE_ERROR_MSG, '', false, PLUGIN_HTML_REALDIR.' に書き込めません。パーミッションをご確認ください。');
        }
    }

    /**
     * アンインストール
     * (アンインストール時に実行)
     *
     * @param array $arrPlugin プラグイン情報
     * @return void
     */
    function uninstall($arrPlugin) {
        // nop
    }

    /**
     * 稼働
     * (プラグインを有効にした際に実行)
     *
     * @param array $arrPlugin プラグイン情報
     * @return void
     */
    function enable($arrPlugin) {
        // nop
    }

    /**
     * 停止
     * (プラグインを無効にした際に実行)
     *
     * @param array $arrPlugin プラグイン情報
     * @return void
     */
    function disable($arrPlugin) {
        // nop
    }

    /**
     * 処理の介入箇所とコールバック関数を設定
     * (プラグインインスタンス生成時に実行)
     *
     * @param SC_Helper_Plugin $objHelperPlugin プラグインヘルパーオブジェクト
     * @param  integer $priority 優先度
     * @return void
     */
    function register(SC_Helper_Plugin $objHelperPlugin, $priority) {
        parent::register($objHelperPlugin, $priority);
    }

/* コールバック関数
----------------------------------------------------------------------------- */
    /**
     * プレフィルタコールバック関数
     *
     * @param string &$source テンプレートのHTMLソース
     * @param LC_Page_Ex $objPage ページオブジェクト
     * @param string $filename テンプレートのファイル名
     * @return void
     */
    function prefilterTransform(&$source, LC_Page_Ex $objPage, $filename) {
        $objTransform = new SC_Helper_Transform($source);
        switch($objPage->arrPageLayout['device_type_id']){
            case DEVICE_TYPE_PC:
                if (strpos($filename, 'shopping/confirm.tpl') !== false) {
                    $objTransform->select('.btn_area')->insertBefore(file_get_contents($this->template_dir . 'pc/plg_RegisterWhileShopping_shopping_confirm.tpl'));
                }
                break;
            case DEVICE_TYPE_SMARTPHONE:
                if (strpos($filename, 'shopping/confirm.tpl') !== false) {
                    $objTransform->select('.btn_area')->insertBefore(file_get_contents($this->template_dir . 'sp/plg_RegisterWhileShopping_shopping_confirm.tpl'));
                }
                break;
            case DEVICE_TYPE_MOBILE:
            case DEVICE_TYPE_ADMIN:
            default:
                break;
        }
        $source = $objTransform->getHTML();
    }

    /**
     * LC_Page->init()の直後
     *
     * @param LC_Page_Ex $objPage ページオブジェクト
     * @return void
     */
    function pagePreProcess(LC_Page_Ex $objPage){
        if (isset($this->arrSelfInfo['plugin_code']) && $this->arrSelfInfo['plugin_code']) {
            $plugin_code = $this->arrSelfInfo['plugin_code'];
            if (!array_key_exists($plugin_code, $_SESSION)) $_SESSION[$plugin_code] = array();
            $this->arrSession =& $_SESSION[$plugin_code];
        }
    }

    /**
     * LC_Page_Shopping_Confirm->action()の直前
     *
     * @param LC_Page_Ex $objPage ページオブジェクト
     * @return void
     */
    function shoppingConfirmActionBefore(LC_Page_Ex $objPage){
        $objCustomer = new SC_Customer_Ex();
        $objPage->plg_RegisterWhileShopping_tpl_login = $objCustomer->isLoginSuccess();

        // ユーザユニークIDの取得
        $objSiteSess = new SC_SiteSession_Ex();
        $uniqid = $objSiteSess->getUniqId();
        // 一時受注テーブルの読込
        $objPurchase = new SC_Helper_Purchase_Ex();
        $objPage->plg_RegisterWhileShopping_arrOrder = $objPurchase->getOrderTemp($uniqid);
        // 会員登録チェックのため、年月日を分ける
        if (!is_null($objPage->plg_RegisterWhileShopping_arrOrder['order_birth'])) {
            $ts = strtotime($objPage->plg_RegisterWhileShopping_arrOrder['order_birth']);
            $objPage->plg_RegisterWhileShopping_arrOrder['order_year'] = date('Y', $ts);
            $objPage->plg_RegisterWhileShopping_arrOrder['order_month'] = date('n', $ts);
            $objPage->plg_RegisterWhileShopping_arrOrder['order_day'] = date('j', $ts);
        }

        // 会員登録用パラメータ
        $objFormParam = new SC_FormParam_Ex();
        SC_Helper_Customer_Ex::sfCustomerEntryParam($objFormParam);
        $objFormParam->setParam($_POST);
        $arrForm = $objFormParam->getHashArray();

        $this->arrSession = array();

        if ($objPage->getMode() == 'confirm') {
            // どこか一ヶ所に入力があったらすべてを入力チェック
            if ($arrForm['password'] != ''
                || $arrForm['password02'] != ''
                || $arrForm['reminder_answer'] != ''
                || $arrForm['reminder'] != '') {

                $objPage->plg_RegisterWhileShopping_arrErr = SC_Helper_Customer_Ex::sfCustomerEntryErrorCheck($objFormParam);
                // 入力エラーの場合は遷移しない
                if (count($objPage->plg_RegisterWhileShopping_arrErr) != 0) {
                    $objQuery = SC_Query_Ex::getSingletonInstance();
                    $arrTableList = $objQuery->listTables();
                    //dtb_tax_ruleテーブルがあれば2.13系、なければ2.12系以前（2.13系で追加されたテーブルのため）
                    if (in_array('dtb_tax_rule', $arrTableList)) $_REQUEST['mode'] = '';
					else $_POST['mode'] = '';

                    // エラーの内容がメールアドレスの登録済みか再登録制限期間内削除ユーザーなら入力欄を非表示にする
                    $email_flg = SC_Helper_Customer_Ex::sfCheckRegisterUserFromEmail($arrForm['email']);
                    if ($email_flg == 1 || $email_flg == 2) {
                        $objPage->plg_RegisterWhileShopping_email_registered = true;
                    }
                } else {
                    // 入力エラーがなければセッションに保存
                    $this->arrSession['customer'] = $objFormParam;
                    $this->arrSession['shipping'] = $this->lfGetShippingInfo($objPurchase);
                }
            }
        }

        $objPage->plg_RegisterWhileShopping_arrFrom = $arrForm;
    }

    /**
     * LC_Page_Shopping_Complete->action()の直前
     *
     * @param LC_Page_Ex $objPage ページオブジェクト
     * @return void
     */
    function shoppingCompleteActionBefore(LC_Page_Ex $objPage){
        if (!array_key_exists('customer', $this->arrSession)) return;

        $this->order_id = $_SESSION['order_id'];

        // 会員登録
        $arrErr = SC_Helper_Customer_Ex::sfCustomerEntryErrorCheck($this->arrSession['customer']);
        // 入力エラーなし
        if (empty($arrErr)) {
            // 登録
            $uniqid = $this->lfRegisterCustomer();
            // メール
            $this->lfSendMail($uniqid, $objPage);

            // 仮会員が無効の場合
            if (CUSTOMER_CONFIRM_MAIL == false) {
                // ログイン状態にする
                $objCustomer = new SC_Customer_Ex();
                $objCustomer->setLogin($this->arrSession['customer']->getValue('email'));
            }
        }

        unset($this->arrSession['customer']);
        unset($this->arrSession['shipping']);
    }

    /**
     * お届け先情報を取得する
     *
     * @param $objPurchase object SC_Helper_Purchaseインスタンス
     * @return array お届け先情報
     */
    function lfGetShippingInfo($objPurchase) {
        // お届け先情報を取得(お届け先ごとの連想配列)
        $arrShippings = $objPurchase->getShippingTemp($objPage->is_multiple);

        // 注文者への配送先は除外する
        if (array_key_exists(0, $arrShippings)) unset($arrShippings[0]);

        return $arrShippings;
    }

    /**
     * 会員登録する
     *
     * @return 会員テーブルのsecret_key
     */
    function lfRegisterCustomer(){
        $objQuery =& SC_Query_Ex::getSingletonInstance();

        $arrCustomer = $this->arrSession['customer']->getDbArray();

        // 生年月日の作成
        $arrCustomer['birth'] = SC_Utils_Ex::sfGetTimestamp($arrCustomer['year'], $arrCustomer['month'], $arrCustomer['day']);

        // 仮会員 1 本会員 2
        $arrCustomer['status']   = (CUSTOMER_CONFIRM_MAIL == true) ? '1' : '2';

        /*
         * secret_keyは、テーブルで重複許可されていない場合があるので、
         * 本会員登録では利用されないがセットしておく。
         */
        $arrCustomer['secret_key'] = SC_Helper_Customer_Ex::sfGetUniqSecretKey();

        //ポイント
        $CONF = SC_Helper_DB_Ex::sfGetBasisData();  // 入会時ポイント
        $arrCustomer['point'] = $CONF['welcome_point'];

        if (SC_Display_Ex::detectDevice() == DEVICE_TYPE_MOBILE) {
            // 携帯メールアドレス
            $arrCustomer['email_mobile'] = $arrCustomer['email'];
            // PHONE_IDを取り出す
            $arrCustomer['mobile_phone_id'] =  SC_MobileUserAgent_Ex::getId();
        }
        $customer_id = SC_Helper_Customer_Ex::sfEditCustomerData($arrCustomer);

        $objQuery->begin();
        // 当該注文の受注履歴の会員ID(0のはず)を、登録した会員IDに変更する(紐付けするため)
        $objQuery->update('dtb_order', array('customer_id' => $customer_id), 'order_id = ?', array($this->order_id));
        // 会員情報の最終購入日、購入合計を更新
        SC_Customer_Ex::updateOrderSummary($customer_id);

        $this->lfRegisterShipping($customer_id, $objQuery);
        $objQuery->commit();

        return $arrCustomer['secret_key'];
    }

    /**
     * 会員のお届け先を追加する
     *
     * @param $customer_id integer 会員ID
     * @param $objQuery object SC_Queryインスタント
     * @return void
     */
    function lfRegisterShipping($customer_id, $objQuery){
        $arrShippingCols = array(
            'name01',
            'name02',
            'kana01',
            'kana02',
            'zip01',
            'zip02',
            'pref',
            'addr01',
            'addr02',
            'tel01',
            'tel02',
            'tel03',
            'fax01',
            'fax02',
            'fax03'
        );
        foreach ($this->arrSession['shipping'] as $arrShipping) {
            $shipping = array('customer_id' => $customer_id);
            foreach ($arrShippingCols as $col) {
                $shipping[$col] = $arrShipping['shipping_' . $col];
            }
            $shipping['other_deliv_id'] = $objQuery->nextVal('dtb_other_deliv_other_deliv_id');
            $objQuery->insert('dtb_other_deliv', $shipping);
        }
    }

    /**
     * 会員登録完了メール送信する
     *
     * @access private
     * @return void
     */
    function lfSendMail($uniqid, $objPage) {
        $arrForm = $this->arrSession['customer']->getHashArray();

        $CONF           = SC_Helper_DB_Ex::sfGetBasisData();

        $objMailText    = new SC_SiteView_Ex();
        $objMailText->setPage($objPage);
        $objMailText->assign('CONF', $CONF);
        $objMailText->assign('name01', $arrForm['name01']);
        $objMailText->assign('name02', $arrForm['name02']);
        $objMailText->assign('uniqid', $uniqid);
        $objMailText->assignobj($objPage);

        $objHelperMail  = new SC_Helper_Mail_Ex();
        $objHelperMail->setPage($objPage);

        // 仮会員が有効の場合
        if (CUSTOMER_CONFIRM_MAIL == true) {
            $subject        = $objHelperMail->sfMakeSubject('会員登録のご確認');
            $toCustomerMail = $objMailText->fetch('mail_templates/customer_mail.tpl');
        } else {
            $subject        = $objHelperMail->sfMakeSubject('会員登録のご完了');
            $toCustomerMail = $objMailText->fetch('mail_templates/customer_regist_mail.tpl');
        }

        $objMail = new SC_SendMail_Ex();
        $objMail->setItem(
            ''                    // 宛先
            , $subject              // サブジェクト
            , $toCustomerMail       // 本文
            , $CONF['email03']      // 配送元アドレス
            , $CONF['shop_name']    // 配送元 名前
            , $CONF['email03']      // reply_to
            , $CONF['email04']      // return_path
            , $CONF['email04']      // Errors_to
            , $CONF['email01']      // Bcc
        );
        // 宛先の設定
        $objMail->setTo($arrForm['email'],
                        $arrForm['name01'] . $arrForm['name02'] .' 様');

        $objMail->sendMail();
    }

}

?>
