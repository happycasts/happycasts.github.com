- <http://discover-devtools.codeschool.com>
- <https://developers.google.com/chrome-developer-tools/docs/>

            
      
### 2. 有用的 console 命令
   
~~~
var text = $0
setInterval( function() { text.textContent = parseInt(text.textContent) - 1; }, 1000);
console.log(document.getElementById('click_here'));
monitorEvents($$('a')[0]) //so so cool
monitorEvents($$('textarea')[0], 'key') //ignore "mouse" events, only log key events
monitorEvents($0, 'mouse') //ignore "key" events 
~~~