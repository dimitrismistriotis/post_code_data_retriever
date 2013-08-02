module PostCodeDataRetriever

  class PostCodeValidator
    ##
    # Magic from here: http://regexlib.com/REDetails.aspx?regexp_id=260&AspxAutoDetectCookieSupport=1
    #
    def self.valid_post_code(input)
      /^([A-PR-UWYZ0-9][A-HK-Y0-9][AEHMNPRTVXY0-9]?[ABEHMNPRVWXY0-9]?{1,2}[0-9][ABD-HJLN-UW-Z]{2}|GIR 0AA)$/
        .match input
    end
  end
end