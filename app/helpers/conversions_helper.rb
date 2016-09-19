module ConversionsHelper

  def error_classes_for(object, attribute)
    "has-error has-feedback" if object.errors[attribute].any?
  end

  def error_text_for(object, attribute)
    if object.errors[attribute].any?
      content_tag(:span, object.errors[attribute].join(", "), class: "help-block") +
      content_tag(:span, "", class: "glyphicon glyphicon-remove form-control-feedback")
    end
  end

  def conversion_result(conversion)
    if conversion.errors[:base].empty?
      "#{conversion.amount} #{conversion.from_ccy} = #{number_with_precision(conversion.converted_amount)} #{conversion.to_ccy} on #{conversion.rate_at}"
    else
      conversion.errors[:base].join(", ")
    end
  end
end
