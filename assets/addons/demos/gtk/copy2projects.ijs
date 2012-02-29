NB. copy2projects.ijs
NB.
NB. copies gtk demos to user projects.
NB.
NB. creates directories ~Projects/image ~Projects/life ~Projects/felidae1 ~Projects/felidae2 ~Projects/felidae3 ~Projects/wd
NB. which should not already exist

3 : 0''
S=. jpath '~addons/demos/gtk/'
T=. jpath '~Projects/'

if. fexist T,'image' do.
  smoutput 'already exists: ',T,'image' return.
end.

if. fexist T,'life' do.
  smoutput 'already exists: ',T,'life' return.
end.

if. fexist T,'felidae1' do.
  smoutput 'already exists: ',T,'felidae1' return.
end.

if. fexist T,'felidae2' do.
  smoutput 'already exists: ',T,'felidae2' return.
end.

if. fexist T,'felidae3' do.
  smoutput 'already exists: ',T,'felidae3' return.
end.

if. fexist T,'wd' do.
  smoutput 'already exists: ',T,'wd' return.
end.

mkdir_j_ each T&, each cutopen 'image/base image/min life/config life/lif life/main felidae1/source felidae1/test felidae2/data felidae2/source felidae2/test felidae3/data felidae3/source felidae3/test wd/source wd/test'

f=. {."1 dirtree S
t=. T&, each (#S) }.each f
empty t fcopynew each f

('~Demos/gtk';'~Projects') dirssrplc T,'image'
('~Demos/gtk';'~Projects') dirssrplc T,'life'
('~Demos/gtk';'~Projects') dirssrplc T,'felidae1'
('~Demos/gtk';'~Projects') dirssrplc T,'felidae2'
('~Demos/gtk';'~Projects') dirssrplc T,'felidae3'
('~Demos/gtk';'~Projects') dirssrplc T,'wd'

)
