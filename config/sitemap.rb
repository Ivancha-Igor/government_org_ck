# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://organizations-ck.herokuapp.com"

SitemapGenerator::Sitemap.create do
  add '/home', changefreq: 'weekly', priority: 0.8
  add '/organizations'
  [:ru, :uk].each do |locale|
    Organization.find_each do |organization|
      add url_for(:controller => 'organizations', :action => 'show', :id => organization, :host => '', :only_path => true, :locale => locale), :lastmod => organization.updated_at, changefreq: 'weekly', priority: 0.8
    end
  end
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
