clear
cd "/Users/Apoorva/Downloads/Data/LSMS 1995-96/Household Data/Individual Level/"
use "Master95-96IND.dta"
drop _merge

merge m:m WWW HH using "/Users/Apoorva/Downloads/Data/LSMS 1995-96/Household Data/Individual Level/Z15B1 Remittances Received.dta", force
drop _merge

gen const = 0
label variable const "Constituency"
label variable DistWard "District - Ward"
sort DistWard
log close _all
log using "labellog", replace

replace const = 1 if (DistWard == "Achham-Bhatakatiya" | DistWard == "Achham-Sutar")
replace const = 2 if (DistWard == "Achham-Kuika" | DistWard == "Achham-Birpath")
replace const = 1 if (DistWard == "Arghakhanchi-Gorkhunga")
replace const = 2 if (DistWard == "Arghakhanchi-Pokharathok")
replace const = 1 if (DistWard == "Baglung-Burtiwang" | DistWard == "Baglung-Kalika" |  DistWard == "Baglung-Singana")
*Baglung 2,3 missing
replace const = 2 if (DistWard == "Baitadi-Durga Bhabani"|DistWard == "Baitadi-Raudidewal")
*Baitadi 1 Missing
replace const = 2 if (DistWard == "Bajhang-Dangaji"|DistWard == "Bajhang-Sainpasela")
replace const = 1 if (DistWard == "Bajhang-Kotdewal")
replace const = 1 if (DistWard == "Bajura-Gudukhati"|DistWard == "Bajura-Pandusain")

replace const = 2 if (DistWard == "Banke-Kalaphanta")
replace const = 3 if (DistWard == "Banke-Nepalgunj")
replace const = 4 if (DistWard == "Banke-Sitapur")
*Banke 1 missing

replace const = 6 if (DistWard == "Bara-Dumbarwana")
replace const = 3 if (DistWard == "Bara-Kalaiya"| DistWard == "Bara-Sisahaniya")
replace const = 2 if (DistWard == "Bara-Parsurampur")
replace const = 1 if (DistWard == "Bara-Bandhuban")
*Bara 4,5 missing

replace const = 3 if (DistWard == "Bardiya-Dhodhari" | DistWard == "Bardiya-Thakudwara")
replace const = 1 if (DistWard == "Bardiya-Motipur")
*Bardiya 2,4 missing

replace const = 1 if (DistWard == "Bhaktapur-Bhaktapur"| DistWard == "Bhaktapur-Chhaling")
*Bhaktapur 1 missing

replace const = 2 if (DistWard == "Bhojpur-Dummana"| DistWard == "Bhojpur-Ranibas")
*Bhojpur 1 missing

replace const = 4 if (DistWard == "Chitwan-Bharatpur Nagar")
replace const = 5 if (DistWard == "Chitwan-Gardi")
replace const = 1 if (DistWard == "Chitwan-Korak"|DistWard == "Chitwan-Pipale")
*Chitwan 2,3 missing

replace const = 1 if (DistWard == "Dadheldhura-Koteli")

replace const = 1 if (DistWard == "Dailekha-Katti")
replace const = 2 if (DistWard == "Dailekha-Santalla")

replace const = 3 if (DistWard == "Dang-Dhikpur")
replace const = 2 if (DistWard == "Dang-Laxmipur")
replace const = 1 if (DistWard == "Dang-Satbariya")
replace const = 4 if (DistWard == "Dang-Urahari")
*Dang 5 missing

save "Master95-96IND.dta", replace

replace const = 1 if (DistWard == "Darchula-Dhuligada"|DistWard == "Darchula-Rithachaupata")

replace const = 1 if (DistWard == "Dhading-Baseri"|DistWard == "Dhading-Sirtung")
replace const = 3 if (DistWard == "Dhading-Jogimara")
replace const = 2 if (DistWard == "Dhading-Nalang")

replace const = 1 if (DistWard == "Dhankuta-Dhankuta")
replace const = 2 if (DistWard == "Dhankuta-Falate")

replace const = 1 if (DistWard == "Dhanusha-Balabakhar")
replace const = 3 if (DistWard == "Dhanusha-Debadiha")
replace const = 5 if (DistWard == "Dhanusha-Gopalpur")
replace const = 4 if (DistWard == "Dhanusha-Janakpur")
replace const = 2 if (DistWard == "Dhanusha-Madhukarahi")
replace const = 6 if (DistWard == "Dhanusha-Raghunathpur")
replace const = 2 if (DistWard == "Dhanusha-Umaprempur")

replace const = 2 if (DistWard == "Dolakha-Bocha")
replace const = 1 if (DistWard == "Dolakha-Gairimudi"|DistWard == "Dolakha-Khupachagu"|DistWard == "Dolakha-Namdu")

replace const = 1 if (DistWard == "Doti-Dipayal"|DistWard == "Doti-Jijodamandau")
replace const = 2 if (DistWard == "Doti-Tikhatar")

replace const = 1 if (DistWard == "Gorkha-Darbhung")
replace const = 3 if (DistWard == "Gorkha-Laprak"|DistWard == "Gorkha-Takukot")
*Gorkha 2 Missing

replace const = 1 if (DistWard == "Gulmi-Harewa")
replace const = 2 if (DistWard == "Gulmi-Reemuwa")
replace const = 3 if (DistWard == "Gulmi-Bhanbhane")

replace const = 1 if (DistWard == "Humla-Shree Nagar")

replace const = 1 if (DistWard == "Ilam-Laxmipura")
replace const = 2 if (DistWard == "Ilam-Bajho")
replace const = 3 if (DistWard == "Ilam-Ilam"|DistWard == "Ilam-Shantidanda")

replace const = 1 if (DistWard == "Jajarkot-Khalanga")
*Jajarkot 2 missing

replace const = 4 if (DistWard == "Jhapa-Arjundhara"|DistWard == "Jhapa-Ghailaduwa")
replace const = 5 if (DistWard == "Jhapa-Chakchaki"| DistWard == "Jhapa-Satasidham")
replace const = 7 if (DistWard == "Jhapa-Dharmpur"|DistWard == "Jhapa-Topgachchi")
replace const = 6 if (DistWard == "Jhapa-Khajurgachhi")
replace const = 3 if (DistWard == "Jhapa-Maheshpur")
*Jhapa 1,2 missing
replace const = 1 if (DistWard == "Jumla-Mahabe PattharKhola")

replace const = 6 if (DistWard == "Kailali-Dhangadhi"| DistWard == "Kailali-Phulwari")
replace const = 3 if (DistWard == "Kailali-Joshipur")
replace const = 4 if (DistWard == "Kailali-Udasipur")
*Kailali 1,2,5 missing

replace const = 1 if (DistWard == "Kalikot-Dholagohe" |DistWard == "Kalikot-Phoi Mahadev")

replace const = 2 if (DistWard == "Kanchanpur-Krishnapur")
replace const = 3 if (DistWard == "Kanchanpur-Pipaladi")
*Kanchanpur 1,4 missing

replace const = 5 if (DistWard == "Kapilbastu-Bishnpur"|DistWard == "Kapilbastu-Jawabhari")
replace const = 2 if (DistWard == "Kapilbastu-Pakadi")
replace const = 3 if (DistWard == "Kapilbastu-Taulihawa")
*Kapilbastu 1,4 missing

replace const = 4 if (DistWard == "Kaski-Dhikurepokhari")
replace const = 1 if (DistWard == "Kaski-Mauja"| DistWard == "Kaski-Thumki")
replace const = 2 if (DistWard == "Kaski-Pokhara")
*Kaski 3 missing

replace const = 9 if (DistWard == "Kathmandu-Balambu")
replace const = 2 if (DistWard == "Kathmandu-Gothatar")
replace const = 9 if (DistWard == "Kathmandu-Kathmandu" )





