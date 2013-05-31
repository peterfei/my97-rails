#My97 Calender 
## Installation
**Step 1**
Load `my97engine` in your `Gemfile` as part of the `assets` group

```
group :assets do 
    gem 'my97engine'
end

**Step 1**
Run 'bundle install'
**Step 3**
Require `WdatePicker.js` in your Javascript manifest (e.g. `application.js`)
```
//= require WdatePicker

**Step 4**
Require `WdatePicker.css` in your CSS manifest (e.g. `application.css`)
```
*= require WdatePicker

## Usage
    <%=f.input :date,:class=>"Wdate" onFocus="WdatePicker({isShowClear:false,readOnly:true})" %>
    <input type="text" class="Wdate" value="" name="test" onFocus="WdatePicker({isShowClear:false,readOnly:true})" />

##Enjoy!!!
--peterfei
