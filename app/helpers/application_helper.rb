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

  def option_filter_menu_by(name: 'tshirt-color')
    option_values = Spree::OptionType.find_by(name: name).option_values
    content_tag :ul, class: 'list-unstyled clearfix' do
      safe_join(option_values.map do |option_value|
        content_tag :li do
          link_to option_value.presentation,
                  potepan_products_path(name.to_sym => option_value.name)
        end
      end, "\n")
    end
  end

  def variants_select_tag(variants, name: 'variant_id', option: {})
    option[:class] ||= 'select-drop'
    option[:multiple] ||= false

    collection = variants.map { |v| [v.options_text, v.id] }
    select_tag(name, options_for_select(collection), multiple: option[:multiple], class: option[:class])
  end

  def quantity_select_tag(name: 'quantity', min: 1, max: 10, option: {})
    option[:class] ||= 'select-drop'
    option[:multiple] ||= false

    collection = (min..max).map { |n| [n, n] }
    select_tag(name, options_for_select(collection), multiple: option[:multiple], class: option[:class])
  end

  def filter_params
    %w(tshirt-size tshirt-color view sort)
  end
end
