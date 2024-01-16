//
//  varlet.swift
//  phw19-3-worldclock
//
//  Created by jasonhung on 2024/1/15.
//

import Foundation

// 映射表，將城市名稱轉換為繁體中文
let cityMapping: [String: String] = [
    "Abidjan": "阿必尚",
    "Accra": "阿克拉",
    "Addis Ababa": "亞的斯亞貝巴",
    "Algiers": "阿爾及爾",
    "Asmara": "阿斯馬拉",
    "Bamako": "巴馬科",
    "Bangui": "班基",
    "Banjul": "班珠爾",
    "Bissau": "比紹",
    "Blantyre": "布蘭太爾",
    "Brazzaville": "布拉柴維爾",
    "Bujumbura": "布琼布拉",
    "Cairo": "開羅",
    "Casablanca": "卡薩布蘭卡",
    "Ceuta": "休達",
    "Conakry": "科納克里",
    "Dakar": "達喀爾",
    "Dar es Salaam": "達累斯薩拉姆",
    "Djibouti": "吉布提",
    "Douala": "杜阿拉",
    "El Aaiun": "阿尤恩",
    "Freetown": "弗里敦",
    "Gaborone": "哈博羅內",
    "Harare": "哈拉雷",
    "Johannesburg": "約翰內斯堡",
    "Juba": "朱巴",
    "Kampala": "坎帕拉",
    "Khartoum": "喀土穆",
    "Kigali": "基加利",
    "Kinshasa": "金沙薩",
    "Lagos": "拉各斯",
    "Libreville": "利伯維爾",
    "Lome": "洛美",
    "Luanda": "羅安達",
    "Lubumbashi": "盧本巴希",
    "Lusaka": "盧薩卡",
    "Malabo": "馬拉博",
    "Maputo": "馬普托",
    "Maseru": "馬塞魯",
    "Mbabane": "姆巴巴內",
    "Mogadishu": "摩加迪沙",
    "Monrovia": "蒙羅維亞",
    "Nairobi": "內羅畢",
    "Ndjamena": "恩賈梅納",
    "Niamey": "尼亞美",
    "Nouakchott": "努瓦克肖特",
    "Ouagadougou": "瓦加杜古",
    "Porto-Novo": "波多諾佛",
    "Sao Tome": "聖多美",
    "Tripoli": "的黎波里",
    "Tunis": "突尼斯",
    "Windhoek": "溫得和克",
    "Adak": "埃達克",
    "Anchorage": "安克拉治",
    "Anguilla": "安圭拉",
    "Antigua": "安提瓜",
    "Araguaina": "阿拉瓜伊納",
    "Buenos Aires": "布宜諾斯艾利斯",
    "Catamarca": "卡塔馬卡",
    "Cordoba": "科爾多瓦",
    "Jujuy": "胡胡伊",
    "La Rioja": "拉里奧哈",
    "Mendoza": "門多薩",
    "Rio Gallegos": "里奧加耶戈斯",
    "Salta": "薩爾塔",
    "San Juan": "聖胡安",
    "San Luis": "聖路易斯",
    "Tucuman": "圖庫曼",
    "Ushuaia": "烏斯懷亞",
    "Aruba": "阿魯巴",
    "Asuncion": "亞松森",
    "Atikokan": "阿提科坎",
    "Bahia": "巴伊亞",
    "Bahia Banderas": "巴伊亞班德拉斯",
    "Barbados": "巴巴多斯",
    "Belem": "貝倫",
    "Belize": "伯利茲",
    "Blanc-Sablon": "布朗-薩布隆",
    "Boa Vista": "博阿維斯塔",
    "Bogota": "波哥大",
    "Boise": "博伊西",
    "Cambridge Bay": "劍橋灣",
    "Campo Grande": "坎普格蘭德",
    "Cancun": "坎昆",
    "Caracas": "卡拉卡斯",
    "Cayenne": "卡宴",
    "Cayman": "開曼",
    "Chicago": "芝加哥",
    "Chihuahua": "奇華華",
    "Costa Rica": "哥斯大黎加",
    "Creston": "克雷斯頓",
    "Cuiaba": "庫亞巴",
    "Curacao": "庫拉索",
    "Danmarkshavn": "丹馬沙文",
    "Dawson": "道森",
    "Dawson Creek": "道森克里克",
    "Denver": "丹佛",
    "Detroit": "底特律",
    "Dominica": "多米尼克",
    "Edmonton": "愛民頓",
    "Eirunepe": "艾魯內佩",
    "El Salvador": "薩爾瓦多",
    "Fort Nelson": "尼爾森堡",
    "Fortaleza": "福塔萊薩",
    "Glace Bay": "格萊斯灣",
    "Godthab": "努克",
    "Goose Bay": "鵝灣",
    "Grand Turk": "大特克",
    "Grenada": "格林納達",
    "Guadeloupe": "瓜德羅普",
    "Guatemala": "危地馬拉",
    "Guayaquil": "瓜亞基爾",
    "Guyana": "圭亞那",
    "Halifax": "哈利法克斯",
    "Havana": "哈瓦那",
    "Hermosillo": "埃莫西約",
    "Indianapolis": "印第安納波利斯",
    "Knox": "諾克斯",
    "Marengo": "馬倫戈",
    "Petersburg": "彼得堡",
    "Tell City": "特爾城",
    "Vevay": "維維",
    "Vincennes": "文森",
    "Winamac": "維納馬克",
    "Inuvik": "伊努維克",
    "Iqaluit": "伊魁特",
    "Jamaica": "牙買加",
    "Juneau": "朱諾",
    "Louisville": "路易斯維爾",
    "Monticello": "蒙蒂塞洛",
    "Kralendijk": "克拉倫代克",
    "La Paz": "拉巴斯",
    "Lima": "利馬",
    "Los Angeles": "洛杉磯",
    "Lower Princes": "下王子",
    "Maceio": "馬塞奧",
    "Managua": "馬那瓜",
    "Manaus": "瑪瑙斯",
    "Marigot": "馬里戈",
    "Martinique": "馬提尼克",
    "Matamoros": "馬塔莫羅斯",
    "Mazatlan": "馬薩特蘭",
    "Menominee": "梅諾米尼",
    "Merida": "梅里達",
    "Metlakatla": "梅特拉卡特拉",
    "Mexico City": "墨西哥城",
    "Miquelon": "米克隆",
    "Moncton": "蒙克頓",
    "Monterrey": "蒙特雷",
    "Montevideo": "蒙得維的亞",
    "Montreal": "蒙特利爾",
    "Montserrat": "蒙特塞拉特",
    "Nassau": "拿騷",
    "New York": "紐約",
    "Nipigon": "尼皮貢",
    "Nome": "諾姆",
    "Noronha": "諾羅尼亞",
    "Beulah": "俾路支",
    "Center": "中心",
    "New Salem": "新塞勒姆",
    "Nuuk": "努克",
    "Ojinaga": "奧希納加",
    "Panama": "巴拿馬",
    "Pangnirtung": "潘尼爾通",
    "Paramaribo": "巴拉馬里博",
    "Phoenix": "鳳凰城",
    "Port-au-Prince": "太子港",
    "Port of Spain": "西班牙港",
    "Porto Velho": "里約熱內盧",
    "Puerto Rico": "波多黎各",
    "Punta Arenas": "蓬塔阿雷納斯",
    "Rainy River": "雷尼河",
    "Rankin Inlet": "蘭金因萊特",
    "Recife": "裡西費",
    "Regina": "裡賈納",
    "Resolute": "瑞索盧特",
    "Rio Branco": "里約布蘭科",
    "Santa Isabel": "聖伊莎貝爾",
    "Santarem": "聖塔倫",
    "Santiago": "聖地牙哥",
    "Santo Domingo": "聖多明哥",
    "Sao Paulo": "聖保羅",
    "Scoresbysund": "斯科雷斯比桑德",
    "Shiprock": "船石",
    "Sitka": "錫特卡",
    "St Barthelemy": "聖巴泰勒米",
    "St Johns": "聖約翰斯",
    "St Kitts": "聖基茨",
    "St Lucia": "聖盧西亞",
    "St Thomas": "聖托馬斯",
    "St Vincent": "聖文森特",
    "Swift Current": "斯威夫特卡倫特",
    "Tegucigalpa": "特古西加爾巴",
    "Thule": "圖勒",
    "Thunder Bay": "雷灣",
    "Tijuana": "提華納",
    "Toronto": "多倫多",
    "Tortola": "托托拉",
    "Vancouver": "溫哥華",
    "Whitehorse": "懷特霍斯",
    "Winnipeg": "溫尼伯",
    "Yakutat": "亞庫塔特",
    "Yellowknife": "耶洛奈夫",
    "Casey": "凱西",
    "Davis": "戴維斯",
    "DumontDUrville": "迪蒙迪烏爾維爾",
    "Macquarie": "麥覺理",
    "Mawson": "莫森",
    "McMurdo": "麥克默多",
    "Palmer": "帕爾默",
    "Rothera": "羅瑟拉",
    "South Pole": "南極點",
    "Syowa": "昭和",
    "Troll": "特羅爾",
    "Vostok": "沃斯托克",
    "Longyearbyen": "隆伊爾城",
    "Aden": "亞丁",
    "Almaty": "阿拉木圖",
    "Amman": "安曼",
    "Anadyr": "阿納德爾",
    "Aqtau": "阿克套",
    "Aqtobe": "阿克托比",
    "Ashgabat": "阿什哈巴德",
    "Atyrau": "阿特勞",
    "Baghdad": "巴格達",
    "Bahrain": "巴林",
    "Baku": "巴庫",
    "Bangkok": "曼谷",
    "Barnaul": "巴爾瑙爾",
    "Beirut": "貝魯特",
    "Bishkek": "比什凱克",
    "Brunei": "汶萊",
    "Calcutta": "加爾各答",
    "Chita": "赤塔",
    "Choibalsan": "朝貝爾桑",
    "Chongqing": "重慶",
    "Colombo": "科倫坡",
    "Damascus": "大馬士革",
    "Dhaka": "達卡",
    "Dili": "帝力",
    "Dubai": "杜拜",
    "Dushanbe": "杜尚別",
    "Famagusta": "法馬古斯塔",
    "Gaza": "加薩",
    "Harbin": "哈爾濱",
    "Hebron": "希伯侖",
    "Ho Chi Minh": "胡志明市",
    "Hong Kong": "香港",
    "Hovd": "科布多",
    "Irkutsk": "伊爾庫茨克",
    "Jakarta": "雅加達",
    "Jayapura": "查亞普拉",
    "Jerusalem": "耶路撒冷",
    "Kabul": "喀布爾",
    "Kamchatka": "堪察加",
    "Karachi": "卡拉奇",
    "Kashgar": "喀什噶爾",
    "Kathmandu": "加德滿都",
    "Katmandu": "加德滿都", // 注意：兩個寫法
    "Khandyga": "肯迪加",
    "Krasnoyarsk": "克拉斯諾亞爾斯克",
    "Kuala Lumpur": "吉隆坡",
    "Kuching": "古晉",
    "Kuwait": "科威特",
    "Macau": "澳門",
    "Magadan": "馬加丹",
    "Makassar": "望加錫",
    "Manila": "馬尼拉",
    "Muscat": "馬斯喀特",
    "Nicosia": "尼科西亞",
    "Novokuznetsk": "新庫茲涅茨克",
    "Novosibirsk": "新西伯利亞",
    "Omsk": "鄂木斯克",
    "Oral": "烏拉爾",
    "Phnom Penh": "金邊",
    "Pontianak": "坤甸",
    "Pyongyang": "平壤",
    "Qatar": "卡塔爾",
    "Qostanay": "科斯塔奈",
    "Qyzylorda": "克孜勒奧爾達",
    "Rangoon": "仰光",
    "Riyadh": "利雅德",
    "Sakhalin": "薩哈林",
    "Samarkand": "撒馬爾罕",
    "Seoul": "首爾",
    "Shanghai": "上海",
    "Singapore": "新加坡",
    "Srednekolymsk": "斯雷德內科林斯克",
    "Taipei": "台北",
    "Tashkent": "塔什干",
    "Tbilisi": "第比利斯",
    "Tehran": "德黑蘭",
    "Thimphu": "廷布",
    "Tokyo": "東京",
    "Tomsk": "托木斯克",
    "Ulaanbaatar": "烏蘭巴托",
    "Urumqi": "烏魯木齊",
    "Ust-Nera": "烏斯季涅拉",
    "Vientiane": "永珍",
    "Vladivostok": "海參崴",
    "Yakutsk": "雅庫茨克",
    "Yangon": "仰光",
    "Yekaterinburg": "葉卡捷琳堡",
    "Yerevan": "葉里溫",
    "Azores": "亞速爾群島",
    "Bermuda": "百慕達",
    "Canary": "加那利群島",
    "Cape Verde": "維德角",
    "Faroe": "法羅群島",
    "Madeira": "馬德拉",
    "Reykjavik": "雷克雅維克",
    "South Georgia": "南喬治亞",
    "St Helena": "聖赫勒拿",
    "Stanley": "斯坦利",
    "Adelaide": "阿德萊德",
    "Brisbane": "布里斯班",
    "Broken Hill": "布羅肯希爾",
    "Currie": "柯里",
    "Darwin": "達爾文",
    "Eucla": "尤克拉",
    "Hobart": "霍巴特",
    "Lindeman": "林德曼",
    "Lord Howe": "豪勳爵",
    "Melbourne": "墨爾本",
    "Perth": "珀斯",
    "Sydney": "悉尼",
    "Amsterdam": "阿姆斯特丹",
    "Andorra": "安道爾",
    "Astrakhan": "阿斯特拉罕",
    "Athens": "雅典",
    "Belgrade": "貝爾格萊德",
    "Berlin": "柏林",
    "Bratislava": "布拉迪斯拉發",
    "Brussels": "布魯塞爾",
    "Bucharest": "布加勒斯特",
    "Budapest": "布達佩斯",
    "Busingen": "布西根",
    "Chisinau": "基希訥烏",
    "Copenhagen": "哥本哈根",
    "Dublin": "都柏林",
    "Gibraltar": "直布羅陀",
    "Guernsey": "根西",
    "Helsinki": "赫爾辛基",
    "Isle of Man": "馬恩島",
    "Istanbul": "伊斯坦堡",
    "Jersey": "澤西",
    "Kaliningrad": "加里寧格勒",
    "Kiev": "基輔",
    "Kirov": "基洛夫",
    "Kyiv": "基輔",
    "Lisbon": "里斯本",
    "Ljubljana": "盧布爾雅那",
    "London": "倫敦",
    "Luxembourg": "盧森堡",
    "Madrid": "馬德里",
    "Malta": "馬爾他",
    "Mariehamn": "瑪麗港",
    "Minsk": "明斯克",
    "Monaco": "摩納哥",
    "Moscow": "莫斯科",
    "Oslo": "奧斯陸",
    "Paris": "巴黎",
    "Podgorica": "波德戈里察",
    "Prague": "布拉格",
    "Riga": "里加",
    "Rome": "羅馬",
    "Samara": "薩馬拉",
    "San Marino": "聖馬力諾",
    "Sarajevo": "薩拉熱窩",
    "Saratov": "薩拉托夫",
    "Simferopol": "辛菲羅波爾",
    "Skopje": "斯科普里",
    "Sofia": "索菲亞",
    "Stockholm": "斯德哥爾摩",
    "Tallinn": "塔林",
    "Tirane": "地拉那",
    "Ulyanovsk": "烏里揚諾夫斯克",
    "Uzhgorod": "烏日哥羅德",
    "Vaduz": "瓦杜茲",
    "Vatican": "梵蒂岡",
    "Vienna": "維也納",
    "Vilnius": "維爾紐斯",
    "Volgograd": "伏爾加格勒",
    "Warsaw": "華沙",
    "Zagreb": "札格瑞布",
    "Zaporozhye": "扎波羅熱",
    "Zurich": "蘇黎世",
    "GMT": "格林威治標準時間",
    "Antananarivo": "安塔那那利沃",
    "Chagos": "查戈斯",
    "Christmas": "聖誕島",
    "Cocos": "科科斯",
    "Comoro": "科摩羅",
    "Kerguelen": "凱爾蓋朗",
    "Mahe": "馬埃",
    "Maldives": "馬爾地夫",
    "Mauritius": "毛里求斯",
    "Mayotte": "馬約特",
    "Reunion": "留尼旺",
    "Apia": "阿皮亞",
    "Auckland": "奧克蘭",
    "Bougainville": "布干維爾",
    "Chatham": "查塔姆",
    "Chuuk": "楚克",
    "Easter": "復活節島",
    "Efate": "埃法特",
    "Enderbury": "恩德伯里",
    "Fakaofo": "法考福",
    "Fiji": "斐濟",
    "Funafuti": "富納富提",
    "Galapagos": "加拉帕戈斯",
    "Gambier": "甘比爾",
    "Guadalcanal": "瓜達爾卡納爾",
    "Guam": "關島",
    "Honolulu": "檀香山",
    "Johnston": "約翰斯頓島",
    "Kanton": "卡通島",
    "Kiritimati": "基里地馬地島",
    "Kosrae": "科斯雷",
    "Kwajalein": "夸贾林",
    "Majuro": "馬朱羅",
    "Marquesas": "馬克薩斯群島",
    "Midway": "中途島",
    "Nauru": "諾魯",
    "Niue": "紐埃",
    "Norfolk": "諾福克島",
    "Noumea": "努美阿",
    "Pago Pago": "帕果帕果",
    "Palau": "帛琉",
    "Pitcairn": "皮特凱恩",
    "Pohnpei": "波納佩",
    "Ponape": "波納佩",
    "Port Moresby": "莫士比港",
    "Rarotonga": "拉羅通加",
    "Saipan": "塞班",
    "Tahiti": "塔希提島",
    "Tarawa": "塔拉瓦",
    "Tongatapu": "東加塔布",
    "Truk": "楚克",
    "Wake": "威克島",
    "Wallis": "瓦利斯"
]