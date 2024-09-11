module SupportsHelper
  def anonymize_name(name)
    names = name.split(" ")
    if names.size >= 2
      "#{names[0]} #{names[1][0]}."
    else
      "Anonymous"
    end
  end
end