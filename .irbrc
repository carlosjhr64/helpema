require 'helpema'
include Helpema

# IRB Tools
require 'irbtools/configure'
_ = Helpema::VERSION.split('.')[0..1].join('.')
Irbtools.welcome_message = "### Helpema(#{_}) ###"
require 'irbtools'
IRB.conf[:PROMPT][:Helpema] = {
  PROMPT_I:    '> ',
  PROMPT_N:    '| ',
  PROMPT_C:    '| ',
  PROMPT_S:    '| ',
  RETURN:      "=> %s \n",
  AUTO_INDENT: true,
}
IRB.conf[:PROMPT_MODE] = :Helpema
