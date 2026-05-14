require "import"
import "android.widget.*"
import "android.view.*"
import "com.androlua.LuaDialog"
import "com.androlua.Http"

-- ========================
-- Local database of all teams and players (same as before, unchanged)
-- ========================
local allTeamsData = {
    ["Our Dhaka"] = {
        {real="Rased Hasan", display="Rased Hasan 154 ⭐ Verified", s="⭐"},
        {real="Mohammad Jabeer", display="Mohammad Jabeer 154 ⭐ Verified", s="⭐"},
        {real="Md Abdullah", display="Md Abdullah 154 ⭐ Verified", s="⭐"},
        {real="Md Amir Hamza", display="Md Amir Hamza 154 ⭐ Verified", s="⭐"},
        {real="Jubayed Ahmed", display="Jubayed Ahmed 154 ⭐ Verified", s="⭐"},
        {real="Md Hasan", display="Md Hasan 154 ⭐ Verified", s="⭐"},
        {real="Ijajul Super", display="Ijajul Super 154 ⭐ Verified", s="⭐"},
        {real="Mohammad Abidur Rahman", display="Mohammad Abidur Rahman 154 ⭐ Verified", s="⭐"},
        {real="Md Rishad Hussain", display="Md Rishad Hussain 154 ⭐ Verified", s="⭐"},
        {real="Junayed M R", display="Junayed M R 154 ⭐ Verified", s="⭐"},
        {real="Ajoy Thakur", display="Ajoy Thakur 154 ⭐ Verified", s="⭐"},
        {real="Taskin Ahmed", display="Taskin Ahmed 154 ⭐ Verified", s="⭐"},
        {real="SM Siyam", display="SM Siyam 154 ⭐ Verified", s="⭐"},
        {real="Raihan", display="Raihan 154 ⭐ Verified", s="⭐"},
        {real="Md Didarul Islam", display="Md Didarul Islam 154 ⭐", s="⭐"},
        {real="Kausar Ali", display="Kausar Ali 154 ⭐", s="⭐"},
        {real="Muhammad Irfan", display="Muhammad Irfan ⭐", s="⭐"},
        {real="Sallu Bhai", display="Sallu Bhai ⭐", s="⭐"},
        {real="Ahammod Hosen", display="Ahammod Hosen ⭐", s="⭐"},
        {real="Md Saadek", display="Md Saadek ⭐", s="⭐"},
    },
    ["India Special Squad"] = {
        {real="Sourabh", display="Pandya Power ⭐", s="⭐"},
        {real="Kishan Dwivedi", display="Colin Cowdrey ⭐", s="⭐"},
        {real="Vaibhav Pande", display="Ajinkya Rahane 3 ⭐", s="⭐"},
        {real="Imran Ansari", display="Deval Babies ⭐", s="⭐"},
        {real="Ansh", display="Matthew Shot ⭐", s="⭐"},
        {real="Satyanand", display="Philips Salt ⭐", s="⭐"},
        {real="Mohit", display="Team Robinson ⭐", s="⭐"},
        {real="Aditya", display="Paradox 75 ⭐", s="⭐"},
        {real="Nitesh", display="Riyan Paraag ⭐", s="⭐"},
        {real="Premchandra Prajapati", display="Premchandra ⭐", s="⭐"},
        {real="Aman Goswami", display="Superhero ⭐", s="⭐"},
        {real="Deepanshu", display="Alis Perry ⭐", s="⭐"},
        {real="Vishal Singh", display="Vishal Singh ⭐ Verified", s="⭐"},
        {real="Krrish Kumar", display="Virat Kohli 82 ⭐", s="⭐"},
        {real="Vishnu Rai", display="Vishnu Rai ⭐", s="⭐"},
    },
    ["King Challengers"] = {
        {real="Syed Suhail Shah", display="Syed Suhail Shah ⭐", s="⭐"},
        {real="Zeeshan", display="Zeeshan 786 Star Verified", s="⭐"},
        {real="Noman", display="Noman Sarfaraz Star Verified", s="⭐"},
        {real="Asif Baloch", display="Asif Baloch ⭐", s="⭐"},
        {real="Aqeel Ahmed Memon", display="Aqeel Ahmed Memon ⭐ Verified", s="⭐"},
        {real="Yusuf Memon", display="Yusuf Memon Star", s="⭐"},
        {real="Taha Memon", display="Taha Memon Star", s="⭐"},
        {real="Nazeer Memon", display="Nazeer Memon ⭐", s="⭐"},
        {real="Amjad Ali Laghari", display="Amjad Ali Laghari Star Verified", s="⭐"},
        {real="Prince Mushtaq Ali", display="Prince Mushtaq Ali ⭐ Verified", s="⭐"},
        {real="Hamza Siddiqui", display="Hamza Siddiqui ⭐", s="⭐"},
        {real="Toseef Khichi", display="Toseef Khichi Star", s="⭐"},
        {real="Iqbal Buneri", display="Iqbal Buneri ⭐", s="⭐"},
        {real="Mohammad Abdullah", display="Mohammad Abdullah Star", s="⭐"},
        {real="Awais Mari", display="Awais Mari ⭐", s="⭐"},
        {real="Abid Nawaz", display="Abid Nawaz TLP Star", s="⭐"},
        {real="Ali Nawaz Mari", display="Ali Nawaz Mari ⭐", s="⭐"},
        {real="Sindhi Kabir", display="Sindhi Kabir Star Verified", s="⭐"},
    },
    ["Shadow Legion"] = {
        {real="Mysterious Rai", display="The Demon King ⭐ Verified", s="⭐"},
        {real="Zohora Akter Antora", display="Antora ⭐ Verified", s="⭐"},
        {real="Limbu", display="Limbu ⭐", s="⭐"},
        {real="Bhanu Chaturvedi", display="Bhanu Chaturvedi ⭐ Verified", s="⭐"},
        {real="MD Khalilur Rahman", display="MD Khalilur666 ⭐ Verified", s="⭐"},
        {real="Arif Ali", display="Prince 786 ⭐", s="⭐"},
        {real="MD Tamim", display="MD Tamim Hosen 666 ⭐ Verified", s="⭐"},
        {real="Ahmed Razzaq", display="Jam Ahmad Razzaq GFO ⭐ Verified", s="⭐"},
        {real="Abishek Karki", display="David Malan 88 ⭐", s="⭐"},
        {real="Samjhana Rijal", display="Samjhana Rijal ⭐", s="⭐"},
        {real="Rahul Singha", display="RS Rahul 45 ⭐ Verified", s="⭐"},
        {real="Banti Raybhole", display="Fantasy Player ⭐", s="⭐"},
        {real="Jitendra Sharde", display="Jitendra Sharde ⭐", s="⭐"},
        {real="Asim Ali", display="Asim Ali TLP ⭐ Verified", s="⭐"},
        {real="Gul Abbas", display="Gul Abbas ⭐", s="⭐"},
        {real="Akshay Saini", display="Akshay Saini ⭐ Verified", s="⭐"},
        {real="Muhammad Awais", display="KING ⭐ Verified", s="⭐"},
        {real="Nasir Riyaz", display="Nasir Riaz DWS ⭐ Verified", s="⭐"},
    },
    ["Durban Super Gents"] = {
        {real="Aditya Sahani", display="King Kohli ⭐", s="⭐"},
        {real="Purushottam Kumar", display="Purushottam Kumar ⭐ Verified", s="⭐"},
        {real="Manjeet Kumar", display="Virendra Sehwag ⭐ Verified", s="⭐"},
        {real="Lavanya Kanchan", display="Lavanya ⭐ Verified", s="⭐"},
        {real="Alok Kumar", display="Alok Kumar ⭐", s="⭐"},
        {real="Krrish", display="Chris ⭐", s="⭐"},
        {real="Aman Dikshit", display="Sunil Narine ⭐", s="⭐"},
        {real="Kanhaiya", display="Mr Kanhaiya ⭐", s="⭐"},
        {real="Rakesh Kumar", display="KL Rahul ⭐", s="⭐"},
        {real="Suraj Kumar", display="Mr Suresh Raina ⭐", s="⭐"},
        {real="Avnish Kumar", display="Yuvraj Singh ⭐", s="⭐"},
        {real="Sundaram Saksena", display="Sundaram ⭐", s="⭐"},
        {real="Akshat Verma", display="Akshat Verma ⭐", s="⭐"},
        {real="Rachit RT", display="Rachit RT ⭐", s="⭐"},
        {real="Aditya Verma", display="Aditya Verma ⭐", s="⭐"},
        {real="Manish", display="Manish ⭐", s="⭐"},
        {real="Suraj Verma", display="Steve Smith ⭐", s="⭐"},
        {real="Prashant Kumar", display="Deval Babies ⭐", s="⭐"},
    },
    ["Karachi Super"] = {
        {real="Umar Farooq", display="Umar Farooq 313 Star", s="⭐"},
        {real="Faisal Baloch", display="Faisal Baloch Star", s="⭐"},
        {real="Noman Qasim", display="Noman Qasim Star", s="⭐"},
        {real="Mrs. Noman Qasim", display="Gloing Star", s="⭐"},
        {real="Abrish Khan", display="Abrish Khan Star", s="⭐"},
        {real="Peehr Hussain Afridi", display="PH Afridi Star", s="⭐"},
        {real="Muhammad Yusuf", display="6 Maro Star", s="⭐"},
        {real="Shahid Khan", display="Shahid Khan Star", s="⭐"},
        {real="Fiza Khan", display="Fiza Khan Star", s="⭐"},
        {real="Abdul Salam", display="Abdul Salam Star", s="⭐"},
        {real="Sujeet Sha", display="Sujeet Sha Star", s="⭐"},
        {real="Acharya Parvina", display="Acharya Parvina Star", s="⭐"},
        {real="Hamza Khan", display="Hamza Khan 786 Star", s="⭐"},
        {real="Hunain Shikh", display="Hunain Shikh Star", s="⭐"},
        {real="Abdul Malik", display="Nawab Haider Ali Star", s="⭐"},
    },
    ["Pakistan Thunders"] = {
        {real="Zamir Yousafzai", display="Zamir Yousafzai Star Verified", s="⭐"},
        {real="Abdullah Adnan", display="Abdullah Adnan Star Verified", s="⭐"},
        {real="Hashir Masood", display="Hashir Masood Star Verified", s="⭐"},
        {real="Ikram Shah", display="Ikram Shah KK Star Verified", s="⭐"},
        {real="Zeeshan Haider", display="Haider Sniper Star Verified", s="⭐"},
        {real="Yasir Mehmood", display="Yasir Mehmood Star", s="⭐"},
        {real="Noman Fiaz", display="Sky Star", s="⭐"},
        {real="Junaid Khan", display="Junaid Khan 💎", s="💎"},
        {real="Habib Ullah", display="Habib Ullah B2 Star", s="⭐"},
        {real="Muhib Ullah", display="Muhib Ullah Star", s="⭐"},
        {real="Waleed Mughal", display="Waleed M Star Verified", s="⭐"},
        {real="Moeen Jutt", display="Moeen Jutt 39 Star Verified", s="⭐"},
        {real="Mukaddam", display="Mukaddam T Star Verified", s="⭐"},
        {real="Irtaza Sajid Abbasi", display="Abbasi Irtaza Star", s="⭐"},
        {real="Talha Shahzad", display="Grant Elliot Star Verified", s="⭐"},
        {real="Ishtiaq Ali", display="Ishtiaq Ali 💎", s="💎"},
        {real="Hamza Khan", display="Fakhar Zaman Star", s="⭐"},
        {real="Qari Fahad", display="Qari Fahad DCF12 Star Verified", s="⭐"},
    },
    ["United Stars"] = {
        {real="Muhammad Shuraim", display="Muhammad Shuraim Star Verified", s="⭐"},
        {real="Ibsham Sami", display="Ibsham Sami T K Star Verified", s="⭐"},
        {real="Mohammad Hussain", display="Bcw Mohammad Hussain PTI Star Verified", s="⭐"},
        {real="Rubas Rashid", display="Rubas Rashid R K Star Verified", s="⭐"},
        {real="Ali Awan", display="Ali Awan Star", s="⭐"},
        {real="Muzammil Baloch", display="Muzammil Baloch ⭐", s="⭐"},
        {real="Hafiz Moiz", display="Hafiz Moiz Star Verified", s="⭐"},
        {real="Aman Zaheer", display="Aman Zaheer Star Verified", s="⭐"},
        {real="Syed M Saadi", display="Syed M Saadi Star", s="⭐"},
        {real="Abdul Rauf", display="Bcw Abdul Rauf Star", s="⭐"},
        {real="Umar Farooq", display="Hak Nawaz Star", s="⭐"},
        {real="Muhammad Ahmed", display="Muhammad Ahmed Star", s="⭐"},
        {real="Mohammad Hassam Raza", display="Tim Seifert Star Verified", s="⭐"},
        {real="Muhammad Fuzail Ali", display="M F A Star Verified", s="⭐"},
        {real="Irtiza Hassan", display="Irtiza Hassan Star Verified", s="⭐"},
        {real="Sheraz Jani", display="Sheraz Jani S M ⭐ Verified", s="⭐"},
    },
    ["Delhi Damang"] = {
        {real="Sumit Jha", display="Sumit Jha ⭐", s="⭐"},
        {real="Ayush", display="Ayush ⭐", s="⭐"},
        {real="Arunabha", display="Arunabha ⭐", s="⭐"},
        {real="Kanhiya", display="Kanhiya ⭐", s="⭐"},
        {real="Nikesh", display="Nikesh ⭐", s="⭐"},
        {real="Balkesh", display="Balkesh ⭐", s="⭐"},
        {real="Sakib", display="Sakib ⭐", s="⭐"},
        {real="Saurav", display="Saurav ⭐", s="⭐"},
        {real="Kunal", display="Kunal ⭐", s="⭐"},
        {real="Sohil", display="Sohil ⭐", s="⭐"},
        {real="Anil", display="Anil ⭐", s="⭐"},
        {real="Shyam", display="Shyam ⭐", s="⭐"},
    },
    ["Virtual Warriors"] = {
        {real="M Shahzad", display="M Shahzad Star Verified", s="⭐"},
        {real="Fida Hussain", display="Sunshine ⭐ Verified", s="⭐"},
        {real="Raees", display="Stylish Khan 47 Star Verified", s="⭐"},
        {real="Hadia", display="Major Jehan Siqandar AHMED Star Verified", s="⭐"},
        {real="Rehmatullah", display="Rehmatullah CK Star Verified", s="⭐"},
        {real="Hamza Riaz", display="Hamza Riaz Star Verified", s="⭐"},
        {real="Shibra Khan", display="Shibra Khan Star Verified", s="⭐"},
        {real="Mahad Hasan", display="Mahad Hasan DK Star Verified", s="⭐"},
        {real="Malik Hussain", display="Malik Hussain GFO Star Verified", s="⭐"},
        {real="M Hamza", display="M Hamza Star", s="⭐"},
        {real="Qasim", display="Qasim Star Verified", s="⭐"},
        {real="Zeeshan Rasool", display="Zeeshan Rasool PATF Star", s="⭐"},
        {real="Muhammad Ramzan", display="Muhammad Ramzan GFO Star Verified", s="⭐"},
        {real="Muneeb Rehmat", display="Muneeb Rehmat 💎", s="💎"},
        {real="Mubashir", display="Mubashir GFO Star", s="⭐"},
        {real="Hafiz Siddeeq", display="Hafiz Siddeeq GFO Star", s="⭐"},
        {real="Shahbaz Raza", display="Super Saraiki GFO Star Verified", s="⭐"},
        {real="Mirza Imran", display="Mirza Imran Star Verified", s="⭐"},
    },
    ["DG Khan Saraiki Star"] = {
        {real="Mohammad Wasim", display="Mohammad Wasim TLP Star Verified", s="⭐"},
        {real="Malik Ahmad", display="Malik Ahmad TLP Star Verified", s="⭐"},
        {real="Mehdi Nabil", display="Mehdi Nabil TLP Star Verified", s="⭐"},
        {real="Mohammad Ramzan", display="Ramzan Khan TLP Star", s="⭐"},
        {real="Aram Malik", display="Aram Malik Star Verified", s="⭐"},
        {real="Mushtaq Ali", display="Prince Mushtaq Ali Star Verified", s="⭐"},
        {real="Mohammad Jahanbaz", display="Jahanbaz Hijwani Star Verified", s="⭐"},
        {real="Ahmed Madani", display="Inzamam ul Haq Star Verified", s="⭐"},
        {real="Maqsood Ali", display="Shaheen Afridi Star", s="⭐"},
        {real="Arman Tanha", display="Arman Tanha Star Verified", s="⭐"},
        {real="Khan Muhammad", display="Khan Muhammad Star", s="⭐"},
        {real="Ambadas Pawar", display="Ambadas Pawar Star", s="⭐"},
        {real="Gulab", display="Pink Star Verified", s="⭐"},
        {real="Moon", display="Shining Star Verified", s="⭐"},
        {real="Zainul Abidin", display="Zain Jatt Star", s="⭐"},
        {real="Mohammad Imran", display="Imran King S 07 Star", s="⭐"},
        {real="Attar Abbas", display="Attar Abbas Star", s="⭐"},
        {real="Gul Abbas", display="Gul Abbas Star", s="⭐"},
        {real="Muhammad Farhan", display="Golden Boy Star", s="⭐"},
        {real="Mubeen Shahzada", display="Mubeen Shahzada Star", s="⭐"},
        {real="Hafiz Hamza Amin", display="Babar Azam Star", s="⭐"},
    },
    ["Young stars"] = {
        {real="Gulam qadir", display="Gulam qadir BK 💎", s="💎"},
        {real="Hammad baig", display="Hammad baig ⭐verified", s="⭐"},
        {real="mohammad hasan", display="mohammad hasans ⭐", s="⭐"},
        {real="ahmed Ali", display="ahmed Ali tlp ⭐", s="⭐"},
        {real="Junaid gujjar", display="Junaid gujjar10 ⭐", s="⭐"},
        {real="dost muhammad", display="dost muhammad ⭐verified", s="⭐"},
        {real="Muhammad Ahmed", display="Muhammad Ahmed 💎", s="💎"},
        {real="Abdul azeem", display="Abdul azeem ⭐", s="⭐"},
        {real="Hafiz mudassir", display="Hafiz mudassir 💎", s="💎"},
        {real="Waseem Atari", display="Waseem Atari ⭐", s="⭐"},
        {real="Ammar faheem", display="Ammar faheem ⭐", s="⭐"},
        {real="guru", display="The one man army ⭐verified", s="⭐"},
        {real="GHULAM deen", display="GHULAM deen ⭐", s="⭐"},
        {real="Samad Khan", display="Samad Khan 1935 ⭐", s="⭐"},
        {real="Hamza Ishaq", display="Hamza Ishaq TLP 💎", s="💎"},
        {real="Mohammed Usman", display="Mohammed Usman9 ⭐", s="⭐"},
        {real="Mehboob Ali", display="Mehboob Ali786Star verified", s="⭐"},
        {real="Ali", display="Ali Ali 💎", s="💎"},
        {real="Mathew", display="Mm ghouri ⭐", s="⭐"},
        {real="Fayaz Patel", display="Fayaz Patel ⭐", s="⭐"},
        {real="yasir siddiqui", display="Azam Khan ⭐", s="⭐"},
        {real="Izzah rubab", display="Izzah rubab ⭐", s="⭐"},
    },
    ["Pakistan United King"] = {
        {real="Muhammad Shahzad Rizvi", display="Muhammad Shahzad Rizvi (Pakistan United Board Star Verified", s="⭐"},
        {real="Muhammad Ramzan", display="Muhammad Ramzan (Star Verified", s="⭐"},
        {real="Ramisha Zaib", display="Ramisha Zaib (Star Verified", s="⭐"},
        {real="Kainat", display="Cutie Doll", s=""},
        {real="Wajiha", display="WJ Sheikh) (Star", s="⭐"},
        {real="Muhammad awais Ali Rizvi", display="Muhammad awais Ali Rizvi (TLP Star Verified", s="⭐"},
        {real="Muhammad Sami", display="Muhammad Sami (TLP Star Verified", s="⭐"},
        {real="Sohail Tanveer", display="Sohail Tanveer (Star Verified", s="⭐"},
        {real="Ansar Ali", display="Ansar Ali (Star", s="⭐"},
        {real="Hafiz Faizan", display="Hafiz Faizan (Star Verified", s="⭐"},
        {real="Muhammad Haseeb", display="Muhammad Haseeb (Star", s="⭐"},
        {real="Rahim", display="Rahim (BSS Star Verified", s="⭐"},
        {real="khorum Shahzad", display="khorum Shahzad star", s="⭐"},
        {real="abubakar Malik", display="abubakar Malik Tech for V I Star Verified", s="⭐"},
        {real="Zain Rajput", display="Zain Rajput  786 Tech for V  I Star Verified", s="⭐"},
        {real="Nabeel", display="Prince Nabeel    39 Star", s="⭐"},
        {real="Aamir Shahzad", display="Aamir Shahzad - Star Verified", s="⭐"},
        {real="Shahid Ali", display="Shahid Ali tec for v  i star verified", s="⭐"},
    },
    ["Silent Snipers"] = {
        {real="Abdul Rehman", display="Abdul Rehman ⭐verified", s="⭐"},
        {real="Muhammad Saif", display="Fakhar Zaman 39 ⭐", s="⭐"},
        {real="Rana Mohiuddin", display="Rana Mohiuddin star verified", s="⭐"},
        {real="Muhammad Hamza", display="Muhammad Hamza Ali ⭐verified", s="⭐"},
        {real="Abdul Waheed Kamal", display="Silent ⭐verified", s="⭐"},
        {real="Salman Jatt", display="Silent Salman ⭐", s="⭐"},
        {real="Muhammad Azan", display="Silent Azan ⭐", s="⭐"},
        {real="Muhammad Idrees", display="Silent Idrees ⭐", s="⭐"},
        {real="Ahmed Umar", display="Kaim Williamson ⭐", s="⭐"},
        {real="Ali Nawaz Maari", display="Ali Nawaz Maari ⭐", s="⭐"},
        {real="Iqra Ayub", display="Hitting Princess ⭐", s="⭐"},
        {real="Aamir Khan", display="Aamir Khan 2026 star", s="⭐"},
        {real="Mustafa Kamal", display="Mustafa Kamal 💎", s="💎"},
        {real="Ali Rehman", display="Ali Rehman 💎", s="💎"},
        {real="Mohammad Haseeb", display="Haseeb Khan star verified", s="⭐"},
        {real="asadullah ghalib", display="asad 786 Tech for v i star verified", s="⭐"},
        {real="Noor", display="Noor 43 star", s="⭐"},
    },
    ["Sky Star Team"] = {
        {real="Jawad Lashari", display="Jawad Sky Star", s=""},
        {real="Hafiz Shoaib", display="Hafiz Shoaib 39 Star", s="⭐"},
        {real="M Hamdan", display="M Hamdan Skystar", s=""},
        {real="Zubair Palanpuri", display="Zubair Palanpuri Star", s="⭐"},
        {real="Tayyab Shoaib", display="Tayyab Sky Star", s=""},
        {real="Walid Jat", display="Kashmiri Mujahid Star", s="⭐"},
        {real="Hafiz Usman", display="Hafiz Usman Star", s="⭐"},
        {real="Muhammad Naeem", display="Muhammad Aamir", s=""},
        {real="Ali Lashari", display="Ali Lashari Star", s="⭐"},
        {real="Mohammad Tahir", display="Ishq Na Karna Star", s="⭐"},
        {real="Nitai Mondal", display="Nitai Mondal Star", s="⭐"},
        {real="Scopy", display="Scopy Star", s="⭐"},
        {real="Acharya Praveena", display="Acharya Praveena Star", s="⭐"},
        {real="Hamza Iqbal", display="Hamza Iqbal Star Verified", s="⭐"},
        {real="Nimra Naaz", display="Nimra Naz Star Verified", s="⭐"},
        {real="Sandee Nikunj", display="Sandee Nikunj Star", s="⭐"},
        {real="Jayant", display="Jayant Star", s="⭐"},
        {real="Preeti Agarwal", display="Preeti Agarwal 💎", s="💎"},
    },
    ["Shaheen Strikers"] = {
        {real="Hafiz Salman", display="Hafiz Salman ⭐", s="⭐"},
        {real="Sabir Hayat", display="Sabir Hayat ⭐", s="⭐"},
        {real="Yash parmar", display="Yash parmar star verify", s="⭐"},
        {real="Ali Raza ansari", display="Ali Raza ansari ⭐", s="⭐"},
        {real="Muhammad Umais", display="umais 295 ⭐", s="⭐"},
        {real="adil nawaz", display="adil nawaz ⭐", s="⭐"},
        {real="Adil gujjar", display="Adil gujjar ⭐", s="⭐"},
        {real="King kaleem", display="King kaleem star", s="⭐"},
        {real="Nisar Ahmed", display="King Baloch ⭐ verify", s="⭐"},
        {real="krish", display="krish ⭐", s="⭐"},
        {real="Shareena urooj", display="Shareena Shines ⭐", s="⭐"},
        {real="Ch abdulrafay", display="Ch abdulrafay ⭐", s="⭐"},
        {real="Vishnu", display="Vishnu bagdi ⭐", s="⭐"},
        {real="Ali Abbas", display="Mehmoona L b s ⭐", s="⭐"},
        {real="Zeeshan ali", display="Zeeshan ali 💎", s="💎"},
        {real="Muhammad Zeshan", display="Muhammad Zeshan ⭐", s="⭐"},
        {real="Hafiz Rashid", display="Rashid tlp ⭐", s="⭐"},
        {real="Mehreen Isshaq", display="Mehreen Isshaq ⭐", s="⭐"},
    },
}

-- ========================
-- Helper functions
-- ========================
function tidy(str)
    if not str then return "" end
    local s = tostring(str):lower()
    s = s:gsub("[^%a%s]", " ")
    s = s:gsub("%s+", " "):match("^%s*(.-)%s*$")
    return s or ""
end

function normalizeForMatch(str)
    if not str then return "" end
    local s = tidy(str)
    s = s:gsub("^mrs?%s+", "")
    s = s:gsub("^mr%s+", "")
    s = s:gsub("^ms%s+", "")
    s = s:gsub("^dr%s+", "")
    s = s:gsub("m[uo]h?ammad", "muhammad")
    s = s:gsub("ahmed", "ahmad")
    s = s:gsub("%s+", " ")
    return s
end

function extractNamesFromLine(line)
    local clean = line:gsub("^%d+%.%s*", "")
    clean = clean:gsub("%*", "")
    clean = clean:gsub("[Cc]aptain:?", "")
    clean = clean:gsub("[Vv]ice [Cc]aptain:?", "")
    clean = clean:gsub("%s+", " ")
    
    local real = ""
    local display = ""
    
    local lower = clean:lower()
    local realStart = lower:find("real name")
    local displayStart = lower:find("display name")
    
    if realStart and displayStart then
        local afterReal = clean:sub(realStart + 9)
        local displayPos = afterReal:lower():find("display name")
        if displayPos then
            real = afterReal:sub(1, displayPos - 1)
            display = afterReal:sub(displayPos + 12)
        else
            real = afterReal
        end
    elseif realStart then
        real = clean:sub(realStart + 9)
    elseif displayStart then
        display = clean:sub(displayStart + 12)
    else
        real = clean
        display = clean
    end
    
    real = real:gsub("%s+[vV]erified%s*", "")
    real = real:gsub("%s+[sS]tar%s*", "")
    real = real:gsub("%s*[⭐💎]%s*", "")
    real = real:gsub("%s+%d+%s*$", "")
    display = display:gsub("%s+[vV]erified%s*", "")
    display = display:gsub("%s+[sS]tar%s*", "")
    display = display:gsub("%s*[⭐💎]%s*", "")
    display = display:gsub("%s+%d+%s*$", "")
    
    real = real:match("^%s*(.-)%s*$") or ""
    display = display:match("^%s*(.-)%s*$") or ""
    
    return real, display
end

-- ========================
-- Load main menu (main.lua)
-- ========================
function loadMainMenu()
    Http.get("https://tournament-manager-lilac.vercel.app/main.lua", function(code, data)
        if code == 200 and data and data:match("%S") then
            local chunk, err = load(data, "=main.lua", "t", _ENV)
            if chunk then
                pcall(chunk)
            else
                Toast.makeText(service, "Failed to load main menu", Toast.LENGTH_LONG).show()
            end
        else
            Toast.makeText(service, "Connection error", Toast.LENGTH_LONG).show()
        end
    end)
end

-- ========================
-- Main verification interface
-- ========================
function showVerificationInterface()
    local mainDialog = LuaDialog(service)
    mainDialog.setTitle("Verify Player List")
    mainDialog.setCancelable(false)
    local layout = LinearLayout(service)
    layout.setOrientation(1)
    layout.setPadding(30,30,30,30)
    
    local edit = EditText(service)
    edit.setHint("Paste list here...")
    edit.setLines(10)
    edit.setGravity(0x30)
    layout.addView(edit)
    
    mainDialog.setView(layout)
    
    mainDialog.setPositiveButton("Verify Now", function()
        local text = edit.getText().toString()
        if text == nil or text:match("^%s*$") then
            local emptyDialog = LuaDialog(service)
            emptyDialog.setTitle("Information")
            emptyDialog.setMessage("Edit box is empty")
            emptyDialog.setPositiveButton("OK", function()
                emptyDialog.dismiss()
            end)
            emptyDialog.show()
            return
        end
        
        -- Process verification
        local lines = {}
        for line in text:gmatch("[^\r\n]+") do
            local trimmed = line:match("^%s*(.-)%s*$")
            if trimmed ~= "" then
                table.insert(lines, trimmed)
            end
        end
        
        if #lines < 2 then
            Toast.makeText(service, "List too short (need team name + at least one player)", Toast.LENGTH_SHORT).show()
            return
        end

        local teamInput = tidy(lines[1])
        local targetTeamKey = nil
        for k, _ in pairs(allTeamsData) do
            local teamNameClean = k:gsub("_", " "):lower()
            if teamInput == teamNameClean or teamInput:find(teamNameClean, 1, true) or teamNameClean:find(teamInput, 1, true) then
                targetTeamKey = k
                break
            end
        end

        if not targetTeamKey then
            Toast.makeText(service, "Team not recognized: " .. lines[1], Toast.LENGTH_LONG).show()
            return
        end

        -- Target team players list
        local targetPlayers = allTeamsData[targetTeamKey]
        
        -- Build a map for quick lookup by normalized real name
        local realNameMap = {}
        for _, player in ipairs(targetPlayers) do
            local normReal = normalizeForMatch(player.real)
            realNameMap[normReal] = player
        end
        
        local resultLines = {}
        local seen = {}

        for i = 2, #lines do
            local raw = lines[i]
            local realName, displayName = extractNamesFromLine(raw)
            
            local normReal = normalizeForMatch(realName)
            local normDisp = normalizeForMatch(displayName)
            
            -- fallback if both empty
            if normReal == "" and normDisp == "" then
                local fallback = normalizeForMatch(raw)
                normReal = fallback
                normDisp = fallback
            end
            
            -- check duplicate in the same list
            local duplicateKey = normReal .. "|" .. normDisp
            if seen[duplicateKey] then
                table.insert(resultLines, string.format("Real Name: %s / Display Name: %s [Information Incorrect] (duplicate in list)", realName, displayName))
                seen[duplicateKey] = true
            else
                seen[duplicateKey] = true
                -- Try to find player by real name first
                local player = realNameMap[normReal]
                if not player then
                    -- If real name not found, try by display name
                    for _, p in ipairs(targetPlayers) do
                        if normalizeForMatch(p.display) == normDisp then
                            player = p
                            break
                        end
                    end
                end
                
                if not player then
                    -- Player not in target team, check if in any other team (optional)
                    local foundElsewhere = false
                    local otherTeam = nil
                    for tName, tSquad in pairs(allTeamsData) do
                        if tName ~= targetTeamKey then
                            for _, p in ipairs(tSquad) do
                                if normalizeForMatch(p.real) == normReal then
                                    foundElsewhere = true
                                    otherTeam = tName:gsub("_", " ")
                                    break
                                end
                            end
                        end
                        if foundElsewhere then break end
                    end
                    if foundElsewhere then
                        table.insert(resultLines, string.format("Real Name: %s / Display Name: %s [Information Incorrect] (belongs to team: %s)", realName, displayName, otherTeam))
                    else
                        table.insert(resultLines, string.format("Real Name: %s / Display Name: %s [Information Incorrect] (not found in any team)", realName, displayName))
                    end
                else
                    -- Player found, now compare display name
                    local expectedFullDisplay = player.display
                    local expectedNormDisplay = normalizeForMatch(expectedFullDisplay)
                    if expectedNormDisplay == normDisp then
                        -- Also check for missing star if required
                        local hasStar = (raw:find("⭐") or raw:lower():find("star"))
                        if player.s == "⭐" and not hasStar then
                            table.insert(resultLines, string.format("Real Name: %s / Display Name: %s [Information Incorrect] (missing star subscription)", realName, displayName))
                        else
                            table.insert(resultLines, string.format("Real Name: %s / Display Name: %s [Information Correct]", realName, expectedFullDisplay))
                        end
                    else
                        table.insert(resultLines, string.format("Real Name: %s / Display Name: %s [Information Incorrect] (wrong display name; expected: %s)", realName, displayName, expectedFullDisplay))
                    end
                end
            end
        end

        -- Result dialog
        local resultDialog = LuaDialog(service)
        resultDialog.setTitle(string.format("Result: %s", targetTeamKey:gsub("_", " ")))
        
        local resultLayout = LinearLayout(service)
        resultLayout.setOrientation(1)
        resultLayout.setPadding(20,20,20,20)
        
        local scroll = ScrollView(service)
        local container = LinearLayout(service)
        container.setOrientation(1)
        for _, line in ipairs(resultLines) do
            local tv = TextView(service)
            tv.setText(line)
            tv.setTextSize(14)
            tv.setPadding(0, 10, 0, 10)
            tv.setFocusable(true)
            container.addView(tv)
        end
        scroll.addView(container)
        resultLayout.addView(scroll, LinearLayout.LayoutParams(-1, 0, 1.0))
        
        local btnLayout = LinearLayout(service)
        btnLayout.setOrientation(0)
        btnLayout.setPadding(0,20,0,0)
        
        local btnCopy = Button(service)
        btnCopy.setText("Copy Result")
        btnCopy.setOnClickListener(function()
            local fullText = table.concat(resultLines, "\n")
            service.copy(fullText)
            Toast.makeText(service, "Copied", Toast.LENGTH_SHORT).show()
            resultDialog.dismiss()
            loadMainMenu()
        end)
        btnLayout.addView(btnCopy, LinearLayout.LayoutParams(-1, -2, 0.5))
        
        local btnOK = Button(service)
        btnOK.setText("OK")
        btnOK.setOnClickListener(function()
            resultDialog.dismiss()
            loadMainMenu()
        end)
        btnLayout.addView(btnOK, LinearLayout.LayoutParams(-1, -2, 0.5))
        
        resultLayout.addView(btnLayout)
        resultDialog.setView(resultLayout)
        resultDialog.show()
    end)
    
    mainDialog.setNegativeButton("Cancel", function()
        mainDialog.dismiss()
        loadMainMenu()
    end)
    
    mainDialog.show()
end

showVerificationInterface()