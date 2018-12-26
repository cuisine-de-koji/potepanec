module ApplicationHelper
  def full_title(page_title = '')
    base_title = "BIGBAG Store"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def taxons_menu(taxonomy_name = Spree::Taxon.root.name, header: true)
    taxonomy = Spree::Taxonomy.find_by(name: taxonomy_name)
    return '' if taxonomy.nil?

    content_tag :ul, class: 'list-unstyled' do
      taxon_header = header ? (content_tag :li, taxonomy.root.name) : ''
      taxons = taxonomy.root.leaves.map do |taxon|
        content_tag :li do
          link_to taxon.name, potepan_category_path(taxon.id)
        end
      end
      safe_join(taxons.unshift(taxon_header).compact, "\n")
    end
  end
end
