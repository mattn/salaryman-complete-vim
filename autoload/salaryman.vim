scriptencoding utf-8

let s:dict = {
\ 'あり' : {'match' : '\(あり\|ari\)', 'cand' : 'ありがとうございました。'},
\ 'いじょ' : {'match' : '\(いじょ\|ijo\)', 'cand' : '以上、宜しくお願い致します。'},
\ 'おい' : {'match' : '\(おい\|oi\)', 'cand' : 'お忙しいところ恐れ入ります。'},
\ 'おせ' : {'match' : '\(おせ\|ose\)', 'cand' : 'お世話になっております、＊＊です。'},
\ 'おつ' : {'match' : '\(おつ\|otu\|otsu\)', 'cand' : 'お疲れ様です、＊＊です。'},
\ 'せん' : {'match' : '\(せん\|sen\)', 'cand' : '先日はありがとうございました。'},
\ 'りょう' : {'match' : '\(りょう\|ryo\|ryou\)', 'cand' : '了解致しました。'},
\ 'ひきつ' : {'match' : '\(ひきつ\|hikitu\|hikitsu\)', 'cand' : '引き続き宜しくお願い致します。'},
\ 'なにと' : {'match' : '\(なにと\|nanito\)', 'cand' : '何卒宜しくお願い致します。'},
\ 'もうし' : {'match' : '\(もうし\|mousi\|moushi\)', 'cand' : '申し訳ございません。'},
\ 'ごて' : {'match' : '\(ごて\|gote\)', 'cand' : 'ご提案させて頂きます。'},
\ 'うえも' : {'match' : '\(うえも\|uemo\)', 'cand' : '上の者と相談致します。'},
\ 'もちけん' : {'match' : '\(もちけん\|mochiken\)', 'cand' : '持ち帰って検討致します。'},
\ 'なるはや' : {'match' : '\(なるはや\|naruhaya\)', 'cand' : 'なるはやで対応致します。'},
\ 'しょうべ' : {'match' : '\(しょうべ\|shoube\|shobe\|syoube\|syobe\)', 'cand' : '正直ベースで申し上げると'},
\ 'うぃ' : {'match' : '\(うぃ\|wi\)', 'cand' : 'ウィンウィンでございます。'},
\ 'おしゃ' : {'match' : '\(おしゃ\|osya\|osha\)', 'cand' : '仰るとおり！'},
\ 'おしごも' : {'match' : '\(おしごも\|oshigomo\|osigomo\)', 'cand' : 'お叱りはごもっとも！'},
\ 'さすござ' : {'match' : '\(さすござ\|sasugoza\)', 'cand' : '流石でございます！'},
\ 'にぽいち' : {'match' : '\(にぽいち\|nipoichi\)', 'cand' : 'いよ、日本一！'},
\ 'おみご' : {'match' : '\(おみご\|omigo\)', 'cand' : ' お見事でございます！'},
\ 'これいぽ' : {'match' : '\(これいぽ\|koreipo\)', 'cand' : 'これは一本取られましたな！'},
\ 'かないま' : {'match' : '\(かないま\|kanaima\)', 'cand' : '敵いませんな！'},
\ 'ないすしょ' : {'match' : '\(ないすしょ\|naisusho\|naisusyo\)', 'cand' : 'ナイスショット！'},
\}

function! salaryman#Complete(findstart, base)
  if a:findstart
    " locate the start of the word
    let lhs = matchstr(getline('.'), '.*\%'.col('.').'c\ze')
    for val in values(s:dict)
      let m = matchstr(lhs, val['match'])
      if len(m) > 0
        return col('.') - strdisplaywidth(m) - 1
      endif
    endfor
    let lhs = matchstr(lhs, '.*[、。，．・？！゛゜ヽヾゝゞ々ー）］｝」』!),.:;?\]}｡｣､･ｰﾞﾟ（［｛「『(\[{｢]')
    if len(lhs)
      return strlen(lhs)
    endif
    return 0
  else
    " find months matching with "a:base"
    for key in keys(s:dict)
      let m = matchstr(a:base, '^'.s:dict[key]['match'])
      if len(m) > 0
        return [s:dict[key]['cand']]
      endif
    endfor
    let ret = filter(keys(s:dict), 'v:val=~"^".a:base')
    if len(ret)
      return ret
    endif
    return []
  endif
endfunction

" vi:set ts=8 sts=2 sw=2 tw=0:
