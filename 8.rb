tree_rows = DATA.readlines.map { _1.chomp.chars.map(&:to_i) }

# A
visible_trees = tree_rows.map.with_index do |row, y|
  row.map.with_index do |tree, x|
    # Edge check
    next 1 if [0, row.length - 1].include?(x)
    next 1 if [0, tree_rows.length - 1].include?(y)

    # Row checks
    next 1 if row[...x].all? { _1 < tree }
    next 1 if row[(x + 1)..].all? { _1 < tree }

    # Colum checks
    next 1 if (0...y).all? { tree_rows[_1][x] < tree }
    next 1 if ((y + 1)...tree_rows.length).all? { tree_rows[_1][x] < tree }

    0
  end
end

pp "A: #{visible_trees.map(&:sum).sum}"

# B
spots = tree_rows.map.with_index do |row, y|
  row.map.with_index do |tree, x|
    left = row[0...x].reverse
    right = row[(x + 1)...]
    up = (0...y).map { tree_rows[_1][x] }.reverse
    down = ((y + 1)...tree_rows.length).map { tree_rows[_1][x] }

    [left, right, up, down].map do |trees|
      visible_trees = trees.take_while { tree > _1 }.count
      if visible_trees != trees.count # not edge stop, include stopping tree
        visible_trees + 1
      else
        visible_trees
      end
    end.inject(:*)
  end
end

pp "B: #{spots.map(&:max).max}"

__END__
222111121311033010320131232031301000043332012154435114414332231343214412243233401310320330011110110
122212201111221321022211311332344223042233341324332523523451325341142120141122414312310331033122112
012111111333222132312234104304231313255134131242541455235523145232422021413232302323121320032011100
211112120020203103314110410023234421314251333452341121341453515343444003001233422242223302311322200
201210231131221012402131143034554222213355322225431255115341554445545541340414012213010002022202002
112200212013012331224041131431522545212335544414555455151514551355224111403003400100040011011022300
011101003322133204344222231251351234321112111235521513115552341343112533431220123311340210102232210
122031031210444124404433321415312412142152324266644622453522311421133335415423110130434110030001112
231221010204100311040145313333451444115452246324454524453256552133145142211341204021224414110333023
032311333241032133333455425531342135163445645454622552233433325553551212411421443333410023110233011
033313120420341201102342315423553325433254625346435255555452263354534422523313343134424134302222233
210122034100322230223332211251432356525226642452544226253323645335644545144314143314114203232233201
333130111103041105432335554425563336553354644636442535232426663555233561411155441141043224222010012
312212201132343322145345553535664245625533624525664643365243662555535264351443134313513234012331221
011333130444110221131515113246666656324635243225344332434632456366452653566435553532552112112032213
003210044223303252524443535666334622643542665555535443466362254665353552645422322315242341403403033
332242132003212314455253226563552223235563544473757777463333354424552234253661232434112101403421313
312040001231533414324525522532442523565457455447433474553354466333564253445332235523141420440313010
104312121145333553241636634542265565346747675566465377577443456755332424665356465551313315142001113
110333013334354152356462424322235575357437745776573354343644766475636435423634252312511111331140311
141131432332153121364256656254575433447565743764665765654744447464344666636246462421234232204031121
210421344342113545663322535663655666645644654374543656737477764537567335662535465542244214221230310
343204325255142551422324234344756654634734465544578576856737376665544467336453352353351443433343304
133102301254412144555533353653547573665778577574784474658644875673576674676562255566151145351220020
223224344451344155434562566467465366767464565858754657655754558766475466334253422436442224555331011
414134415213314456325425437336367533788666656447548675457765658746477537745433342326452115553504140
210220312315314644352222464334765645485454558884884488448467888485637473436652422342535312532412012
410423143113532346654334464376736884864787878768676457866557654777446347447647354324563313343220203
123243144133262345545256434334564557855848445554744857555585647647767444654456422535563521235243101
001221553423336564562666565736587774456465648898999685976544845644768477675755364556264352421541240
122455431434364334357455445775865787578877575556698669577858545764465455557447574253635442532141334
411322422344655432444773444737544688648489665565766575656669686646756668737355663445622544353343501
100452234113255564277755453355766887888586995558877975687759596677857745857655536652566326321412212
300321555452652544547664377576778647768898965888758668657676868865468558763557437755625566245113434
343134514136456336357653376657445885886886867655777985785856897895876848466663747375233322523121142
114541412565432526734546638486445869798568898996999669867895689986867586854774447772523645343252212
335525335324365625374537668645856485977698886978879966598557868688888875488534663477325444313251455
005254243666643553335555487677767596587886656767889998979868697788864858685633474575633523331321214
312215232353626454653665786656777659797585696766967999978995665688555458666466575656533425421315124
455254144343565245534457487587747957689887878877887789789877655695559745874753576745665245552435435
052531252233234335647575675676896959999677999989776697788798799996668944567556466567723324364342355
054243123465333465754648858585758857559769786667689667798989789966569746575885756753326434235251553
324142315545624734655445888787888855777696799978997976798969776559679997446665443364532234642425322
331143113242355447635758688655678979588766798866877787866789899598967898587775667633445363664512251
142522126265354464773765445857886955789988699988879777868696666776665574854564573735562433654124245
532514343454323667477744576876799789966977669979989877788977667859777599677745877635536544533143253
344545426243435744343376464578856699899887978997787989998696799797577777567558475657764653542225144
253432255553235755377468677456777795699966888787887897879866699998975869654575775746563265454212522
121223425445367534767578484546968968987668897897978877788669687696598856456654576464556544566231332
541542252523453663537744676876766989777978898799799789989976678998559565865588533754744432534552324
342114233543525554546576868665598999696998978979879977987969766966565589668874563547473562232334521
154335346326353677637687666857966758686688987899878897798796999698597787658557467346733342433315211
313415365663355547557456858557996769697967868987797887978766688789758887858685456373733366455413432
112141226362543644556378788749969857997887797989888978987886666675989658844678673543374265335634453
112344252456244637356468588448876696598986989977798878899877688657895999588557866537366554326242445
444133113256243335654555768868996955579688996889877998999988677775777665746458546336675245444214445
234143214235456765755554485688978868779989788989888799789778886996959575685568655457755333642253523
235444232433252456333444744474656795876689967766878786986699689687798885758464357333464234652444511
134335515644564474374558768467685896979687996677696868679888676599687655687665676534546554262215313
443322212224554654475565646767558876567696869686869989977786668597857957566578644636342255264553155
351215324422333544473344745468768999876569887768769996669869678668866778486668443437545655326415211
354341132423642657557355868866688587767577676879969777769668697986957456447443473365526525552443133
133153153354566553334634756678877589665868987689669698978968675766875684856466676656353354241225525
041433511462563343556756567546857779869988956966767967889656585869798548484854554667465554331321231
103335423462624233763574365478864686795899959589689896779758775998668657746475666776465443242543435
415341553545553364343664774665645559686665696597976597558655877598848478474764637573322426514444521
413135352325454455433647757684556576588586787695669988795756586694645754467574467654265363444411132
122435422332525436647775654665744648796566885895865887875987998558664677466374446462544654214553452
143451324343325455537645354344848887559958665997958657685695686664885868463663654564245522354335452
140345552145363346546744346775884776848557878758757558976668655876767454657544744652355561245512220
133424122115264566663754443543484774687588567588968968566797884785655454474764444336453641334422411
430225343531365542622366437654657767744546456986698585956784588658557534576676755525444445134332144
132141154343324524552434363747334746874878878657686665786765646665775334476375453564326252242351042
011240412422452444635423754373666875644444877848545768684576568878887556577455663243454333511112202
124122143452533543243334456547633558557745885486486856674558847678437564344733462422223421121444342
202111352125551452552345257745435343756687677668545668488787887785774565433534422436534555541524032
011111153312344355323634663576735753767584575558746877488666764437644637363343242526551231451302400
203434244145452344656634524547376766563577586448468666748847734375474353362264444436151534124313440
342314103434454513633362623574747357563655344675786685458353544566755333765363343261543224532134214
241334002225235424466266566237646456443535447765555375756456463336545335555533523435455432354023021
304231030435325552536325564235753645736364544545664344543735763537673554536646543341445533213004022
304322241414212423545425226254344543473444376365575545753674674374655565655245546552152132141034020
210042001023332321132342634254523347463543745557464437754357577655734546455355541325323345031443030
300414014030231115124123223265262436374677453653356356346477645632536532655643253535142244120121021
001312300013141454533135443642526632266555375344736735657644344335566325235451153515513142034100330
013201431240135541445522126524463364266264655654676555767756454256556363364435532235434021101023233
111022343031223352312335526234546554625335526364667352235436424655365253354412251324330304334340121
020301221001412242411521315324665665444335552536345444562424265464323663523253335324112004213243300
200003330101140324114255532334623565323564544246446342553545244566663322411321421331334123322132332
111201102322233423425523514545515466424463642252526633545566223643433135415424254141242411023230022
020231110313114023022353552251344225432366626243523233645624534554615322132224421032322440221031201
301022321122422204341332335144544431266225323454554263662363634613554225253332343112422302332121301
003212121330022234213114334313435533321232365626526434454643352531424544444522540021023414301300021
002120113123011130334332255411142544515153523532265342254412514344521512353310211103000231031031011
022203312301242240003143035455131453355133544225251133255421242244332211125211002432133432232223122
012123230121332102102424233251314432151355431432134121155141444345425134423412430343100031011112021
020112120011000300140413323004541541313533412411343535545541114212354343042322023310233133333311001
021211311100312300343030212031113424325144412424131143321533111542453240031234420030132023031301100
201110012103213102203214024221011425542134412551412254115235145223401121144333313120222002303312001
