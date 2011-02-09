<?php
require('lib/header.php');
require('lib/lib_history.php');
if (!is_logged()) {
    header("Location:index.php");
    return;
}

if (isset($_POST['comment']))
    $comment = mysql_real_escape_string($_POST['comment']);
else
    $comment = '';

if (isset($_GET['set_id']) && $set_id = (int)$_GET['set_id']) {
    revert_changeset($set_id, $comment);
}
elseif (isset($_GET['tf_rev']) && $rev_id = (int)$_GET['tf_rev']) {
    revert_token($rev_id);
}
elseif (isset($_GET['dict_rev']) && $rev_id = (int)$_GET['dict_rev']) {
    revert_dict($rev_id);
} else {
    show_error();
}
?>