# module Net
#   class SMTP
#     def mailfrom(from_addr)
#       # if $SAFE > 0
#       #   raise SecurityError, 'tainted from_addr' if from_addr.tainted?
#       # end
#       # getok("MAIL FROM:#{from_addr}")
#       "MAIL FROM:#{from_addr}"
#     end
#   end
# end