# -*- coding: utf-8 -*-
require 'base64'

Plugin.create :mikutter_base64 do

  command(:decode_base64,
          name: "このツイートを base64 としてデコード",
          condition: Plugin::Command[:HasMessage],
          visible: true,
          role: :timeline) do |target|
    
    target.messages.each do |mes|
      begin
        md = Gtk::MessageDialog.new(nil, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::WARNING, 
                                    Gtk::MessageDialog::BUTTONS_CLOSE, ((t = Base64.decode64(mes[:message]).gsub(/^\. ?/, '').gsub(/@[a-zA-Z0-9_]*/, '')) == "") ? "not valid base64" : t)
        md.run
        md.destroy
      rescue => err
        p err
      end
    end
  
  end

  command(:encode_base64,
          name: "現在の Postbox の内容を base64 でエンコード",
          condition: lambda { |opt| true },
          visible: true,
          role: :postbox) do |opt|
    box = Plugin[:gtk].widgetof(opt.widget).widget_post.buffer
    box.text = Base64.encode64(box.text)
  end

end
