{* Smarty *}
{extends file='common.tpl'}
{block name=body}<body onload="highlight_source(); document.onkeyup=checkKeyUp; document.onkeydown=checkKeyDown; document.onmouseup=endScroll; prepareScroll();">{/block}
{block name=content}
    {strip}
    <script type="text/javascript">
        $(document).ready(function(){
            $("#source_text,#main_scroller,#scrollbar").mousewheel(function(event,delta){
                byid('scrollbar').state = delta > 0 ? -1: 1;
                scroll_annot( delta>0 ? -50 : 50);
                endScroll();
                event.preventDefault()
                })
            })
    </script>
    <p align='right'>
    {if $sentence.status == 0}
    <span class='sent_status0'>{t}Предложение разобрано автоматически.{/t}</span>
    {elseif $sentence.status == 1}
    <span class='sent_status1'>{t}Частично снята омонимия.{/t}</span>
    {/if}
    </p>
    <div id="source_text"><b>{t}Весь текст{/t}:</b> {$sentence.fulltext}</div>
    <form method="post" action="?id={$sentence.id}&amp;act=save">
        <div id="main_scroller">
            <div>
                {if $is_logged == 1}
                    <button type="button" disabled="disabled" id="submit_button" onclick="show_comment_field(this)">{t}Сохранить{/t}</button>&nbsp;
                {/if}
                <button type="reset" onclick="window.location.reload()">{t}Отменить правки{/t}</button>&nbsp;
                <button type="button" onclick="window.location.href='history.php?sent_id={$sentence.id}'">{t}История{/t}</button>&nbsp;
                <button type="button" onclick="dict_reload_all()">{t}Разобрать заново{/t}</button>
                <br/>
                <span id='comment_fld'>{t}Комментарий{/t}: <input name='comment' size='60'/></span>
            </div>
        </div>
        <div id="scrollbar"><div style="height:10px;"></div></div>
        <div id="main_annot"><table><tr>
        {foreach item=token from=$sentence.tokens}
            <td id="var_{$token.tf_id}">
                <div class="tf">
                    {$token.tf_text|htmlspecialchars}
                    {if $token.dict_updated == 1}
                        <a href="#" class="reload" title="{t}Разобрать заново из словаря{/t}" onClick="dict_reload(this.parentNode.parentNode)">D</a>
                    {/if}
                </div>
                {foreach item=variant from=$token.variants}
                    <div class="var" id="var_{$token.tf_id}_{$variant.num}">
                        <input type="hidden" name="var_flag[{$token.tf_id}][{$variant.num}]" value="1"/>
                        {if $variant.lemma_id > 0}
                            <a href="{$web_prefix}/dict.php?act=edit&amp;id={$variant.lemma_id}">{$variant.lemma_text}</a>
                        {else}
                            <span class='lt'>{$variant.lemma_text|htmlspecialchars}</span>
                        {/if}
                        <a href="#" class="best_var" onclick="best_var(this.parentNode); return false">v</a>
                        <a href="#" class="del_var" onclick="del_var(this.parentNode); return false">x</a>
                        <br/>
                        {foreach item=gram from=$variant.gram_list name=gramf}
                        <span class='hint' title='{$gram.descr}'>
                        {if isset($smarty.session.options) && $smarty.session.options.1 == 1}
                            {$gram.outer|default:"<b class='red'>`$gram.inner`</b>"}
                        {else}
                            {$gram.inner}
                        {/if}
                        </span>{if !$smarty.foreach.gramf.last}, {/if}
                        {/foreach}
                    </div>
                {/foreach}
            </td>
        {/foreach}
        </tr></table></div>
    </form>
    {/strip}
{/block}