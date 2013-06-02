#My97-rails
## Installation
**Step 1**
Load `my97-rails` in your `Gemfile` as part of the `assets` group

```
group :assets do 
    gem 'my97-rails'
end
```
**Step 2**
```
Run 'bundle install'
```
**Step 3**
Require `WdatePicker.js` in your Javascript manifest (e.g. `application.js`)
```
//= require WdatePicker
```
**Step 4**
Require `WdatePicker.css` in your CSS manifest (e.g. `application.css`)
```
*= require WdatePicker
```
## Usage

```
    <%=f.my97_date_select :date,:class=>"Wdate"  %>

    <%=f.my97_datetime_select :date,:class=>"Wdate" %>

```

##Enjoy!!!
![](http://l.ruby-china.org/photo/f1328a8b7a2e874c95105f5777f89838.png)

--peterfei
