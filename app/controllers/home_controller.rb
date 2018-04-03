class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:edit,:update,:destroy]
  def index
    @page=Page.where(is_home: true).first
       set_meta_tags og: {
                  url: "#{request.base_url + request.original_fullpath}",
                  type: "website",
                  title: "#{@page.nil? ? "" : @page.title} Software Libre y Codigo Abierto Panama",
                  description: @page.nil? ? "" : @page.content,
                  site_name: "floss-pa",
                  image: "https://floss-pa.net/images/logo.png}"
                  }
    set_meta_tags twitter: {
                card:  "summary",
                description: @page.nil? ? "" : @page.content,
                title: @page.nil? ? "" : @page.title,
                creator: "@flosspa",
                image: {
                        _:       "https://floss-pa.net/images/logo.png}",
                        width:  100,
                        height: 100,
                },
                domain: "Floss-pa"
                }
  end
  def privacy
    @page=Page.find(2)
  end
end
