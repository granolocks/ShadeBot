#       ___           ___           ___           ___           ___
#      /\  \         /\__\         /\  \         /\  \         /\  \
#     /::\  \       /:/  /        /::\  \       /::\  \       /::\  \
#    /:/\ \  \     /:/__/        /:/\:\  \     /:/\:\  \     /:/\:\  \
#   _\:\~\ \  \   /::\  \ ___   /::\~\:\  \   /:/  \:\__\   /::\~\:\  \
#  /\ \:\ \ \__\ /:/\:\  /\__\ /:/\:\ \:\__\ /:/__/ \:|__| /:/\:\ \:\__\
#  \:\ \:\ \/__/ \/__\:\/:/  / \/__\:\/:/  / \:\  \ /:/  / \:\~\:\ \/__/
#   \:\ \:\__\        \::/  /       \::/  /   \:\  /:/  /   \:\ \:\__\
#    \:\/:/  /        /:/  /        /:/  /     \:\/:/  /     \:\ \/__/
#     \::/  /        /:/  /        /:/  /       \::/__/       \:\__\
#      \/__/         \/__/         \/__/         ~~            \/__/
#
#      /\  \         /\  \         /\  \
#     /::\  \       /::\  \        \:\  \
#    /:/\:\  \     /:/\:\  \        \:\  \
#   /::\~\:\__\   /:/  \:\  \       /::\  \
#  /:/\:\ \:|__| /:/__/ \:\__\     /:/\:\__\
#  \:\~\:\/:/  / \:\  \ /:/  /    /:/  \/__/
#   \:\ \::/  /   \:\  /:/  /    /:/  /
#    \:\/:/  /     \:\/:/  /     \/__/
#     \::/__/       \::/  /
#      ~~            \/__/
#

require 'twitter'

$:.unshift(File.dirname(__FILE__))

require 'ext/string'
require 'ext/twitter_tweet'

module ShadeBot ; end

require 'shadebot/twitter_client'
require 'shadebot/tweet_handler'