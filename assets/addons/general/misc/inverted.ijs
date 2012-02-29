NB. Title             Essays/Inverted Table - J Wiki
NB. Current URL       http://www.jsoftware.com/jwiki/Essays/Inverted%20Table
NB.
NB. Collected Definitions

cocurrent 'z'

ifa =: <@(>"1)@|:               NB. inverted from atoms
afi =: |:@:(<"_1@>)             NB. atoms from inverted

tassert=: 3 : 0
 assert. (1>:#$y) *. 32=3!:0 y  NB. boxed scalar or vector
 assert. 1=#~.#&>y              NB. same # items in each box (with at least one box)
 1
)

ttally    =: #@>@{.
tfrom     =: <@[ {&.> ]
tindexof  =: i.&>~@[ i.&|: i.&>
tmemberof =: i.&>~ e.&|: i.&>~@]
tless     =: <@:-.@tmemberof #&.> [
tnubsieve =: ~:@|:@:(i.&>)~
tnub      =: <@tnubsieve #&.> ]
tkey      =: 1 : '<@tindexof~@[ u/.&.> ]'
tgrade    =: > @ ((] /: {~)&.>/) @ (}: , /:&.>@{:)
tgradedown=: > @ ((] \: {~)&.>/) @ (}: , \:&.>@{:)
tsort     =: <@tgrade {&.> ]

NB. alternatives
tmemberof1=: tindexof~ < ttally@]
tnubsieve1=: tindexof~ = i.@ttally
ranking   =: i.!.0~ { /:@/:
tgrade1   =: /: @ |: @: (ranking&>)

