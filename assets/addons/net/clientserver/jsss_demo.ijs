NB. class extended from jsss - Simple Socket Server
NB. a demo server application
NB. copy this file and edit as required to create your server application

require '~addons/net/clientserver/jsss.ijs'
cocurrent 'jsss'   NB. add new or redefined defns to jsss class

NB. server methods are defined as cmd_method verbs
NB. demo server methods
cmd_test=: [
cmd_average=: +/ % #
cmd_reverse=: |.
cmd_matrix_product=: +/ .*