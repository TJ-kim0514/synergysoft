window.onload = function() {
	// contextPath 가져오기
	const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	console.log(contextPath);

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(37.501300, 127.025141), // 지도의 중심좌표
	        level: 5, // 지도의 확대 레벨
	    };
	
	var map = new kakao.maps.Map(mapContainer, mapOption);// 지도를 생성합니다
	
	// 버튼을 클릭하면 아래 배열의 좌표들이 모두 보이게 지도 범위를 재설정합니다 
	var points = [
	    new kakao.maps.LatLng(37.530126, 127.1237708),
		new kakao.maps.LatLng(37.5145636, 127.1059186),
		new kakao.maps.LatLng(37.517305, 127.047502),
		new kakao.maps.LatLng(37.483569, 127.032598),
		new kakao.maps.LatLng(37.4781549, 126.9514847),
		new kakao.maps.LatLng(37.51245, 126.9395),
		new kakao.maps.LatLng(37.526436, 126.896004),
		new kakao.maps.LatLng(37.4568644, 126.8955105),
		new kakao.maps.LatLng(37.495472, 126.887536),
		new kakao.maps.LatLng(37.550937, 126.849642),
		new kakao.maps.LatLng(37.517016, 126.866642),
		new kakao.maps.LatLng(37.5663245, 126.901491),
		new kakao.maps.LatLng(37.579225, 126.9368),
		new kakao.maps.LatLng(37.602784, 126.929164),
		new kakao.maps.LatLng(37.654358, 127.056473),
		new kakao.maps.LatLng(37.668768, 127.047163),
		new kakao.maps.LatLng(37.6397819, 127.0256135),
		new kakao.maps.LatLng(37.5894, 127.016749),
		new kakao.maps.LatLng(37.6063242, 127.0925842),
		new kakao.maps.LatLng(37.574524, 127.03965),
		new kakao.maps.LatLng(37.538617, 127.082375),
		new kakao.maps.LatLng(37.563456, 127.036821),
		new kakao.maps.LatLng(37.532527, 126.99049),
		new kakao.maps.LatLng(37.563843, 126.997602),
		new kakao.maps.LatLng(37.5735207, 126.9788345),
		new kakao.maps.LatLng(38.075493, 128.619145),
		new kakao.maps.LatLng(38.3806154, 128.4678625),
		new kakao.maps.LatLng(38.069732, 128.170352),
		new kakao.maps.LatLng(38.109992, 127.99),
		new kakao.maps.LatLng(38.106181, 127.708216),
		new kakao.maps.LatLng(38.146861, 127.313472),
		new kakao.maps.LatLng(37.380609, 128.660871),
		new kakao.maps.LatLng(37.37077, 128.390193),
		new kakao.maps.LatLng(37.183774, 128.46185),
		new kakao.maps.LatLng(37.491803, 127.985022),
		new kakao.maps.LatLng(37.697207, 127.888518),
		new kakao.maps.LatLng(37.4499354, 129.1651479),
		new kakao.maps.LatLng(38.207169, 128.59184),
		new kakao.maps.LatLng(37.164132, 128.985735),
		new kakao.maps.LatLng(37.5247583, 129.1142625),
		new kakao.maps.LatLng(37.752175, 128.875836),
		new kakao.maps.LatLng(37.3423179, 127.9199688),
		new kakao.maps.LatLng(37.8813739, 127.7300034),
		new kakao.maps.LatLng(37.491791, 127.487597),
		new kakao.maps.LatLng(37.831508, 127.509541),
		new kakao.maps.LatLng(38.096738, 127.074755),
		new kakao.maps.LatLng(37.2953583333333, 127.639622222222),
		new kakao.maps.LatLng(37.894867, 127.2002404),
		new kakao.maps.LatLng(37.785329, 127.045847),
		new kakao.maps.LatLng(37.4294306, 127.2550476),
		new kakao.maps.LatLng(37.199565, 126.831405),
		new kakao.maps.LatLng(37.61535, 126.715544),
		new kakao.maps.LatLng(37.0080546, 127.2797732),
		new kakao.maps.LatLng(37.272342, 127.435034),
		new kakao.maps.LatLng(37.760186, 126.779883),
		new kakao.maps.LatLng(37.2412522, 127.1774916),
		new kakao.maps.LatLng(37.5393014, 127.2148742),
		new kakao.maps.LatLng(37.3448869, 126.9682786),
		new kakao.maps.LatLng(37.361523, 126.935338),
		new kakao.maps.LatLng(37.380177, 126.802934),
		new kakao.maps.LatLng(37.149887, 127.077462),
		new kakao.maps.LatLng(37.635985, 127.216467),
		new kakao.maps.LatLng(37.594266, 127.129632),
		new kakao.maps.LatLng(37.4292013, 126.987675),
		new kakao.maps.LatLng(37.6583981, 126.8319831),
		new kakao.maps.LatLng(37.3219123, 126.8308176),
		new kakao.maps.LatLng(37.903662, 127.060671),
		new kakao.maps.LatLng(36.9923537, 127.1126947),
		new kakao.maps.LatLng(37.4786176, 126.8646504),
		new kakao.maps.LatLng(37.5035917, 126.766),
		new kakao.maps.LatLng(37.3942905, 126.9567534),
		new kakao.maps.LatLng(37.738083, 127.033753),
		new kakao.maps.LatLng(37.4200267, 127.1267772),
		new kakao.maps.LatLng(37.263476, 127.028646),
		new kakao.maps.LatLng(35.56666, 128.165799),
		new kakao.maps.LatLng(35.686698, 127.909538),
		new kakao.maps.LatLng(35.520536, 127.725245),
		new kakao.maps.LatLng(35.415557, 127.873458),
		new kakao.maps.LatLng(35.067333, 127.751275),
		new kakao.maps.LatLng(34.837707, 127.892475),
		new kakao.maps.LatLng(34.9730975, 128.3222643),
		new kakao.maps.LatLng(35.544611, 128.492346),
		new kakao.maps.LatLng(35.272315, 128.406595),
		new kakao.maps.LatLng(35.3222239, 128.261676),
		new kakao.maps.LatLng(35.335049, 129.037339),
		new kakao.maps.LatLng(34.8804572, 128.6211703),
		new kakao.maps.LatLng(35.503856, 128.746712),
		new kakao.maps.LatLng(35.228574, 128.889322),
		new kakao.maps.LatLng(35.0034774, 128.0638649),
		new kakao.maps.LatLng(34.85439, 128.433112),
		new kakao.maps.LatLng(35.180325, 128.107646),
		new kakao.maps.LatLng(35.2278771, 128.6818746),
		new kakao.maps.LatLng(37.484455, 130.905697),
		new kakao.maps.LatLng(36.993087, 129.400394),
		new kakao.maps.LatLng(36.893114, 128.732503),
		new kakao.maps.LatLng(36.6468844, 128.4373552),
		new kakao.maps.LatLng(35.9955753, 128.401679),
		new kakao.maps.LatLng(35.919175, 128.282959),
		new kakao.maps.LatLng(35.725968, 128.262688),
		new kakao.maps.LatLng(35.647399, 128.733988),
		new kakao.maps.LatLng(36.415034, 129.365267),
		new kakao.maps.LatLng(36.6667174, 129.1123839),
		new kakao.maps.LatLng(36.4362793, 129.0571263),
		new kakao.maps.LatLng(36.3527158, 128.6971711),
		new kakao.maps.LatLng(36.242945, 128.572657),
		new kakao.maps.LatLng(35.82509, 128.741201),
		new kakao.maps.LatLng(36.586522, 128.186787),
		new kakao.maps.LatLng(36.411002, 128.159229),
		new kakao.maps.LatLng(35.97326, 128.938613),
		new kakao.maps.LatLng(36.805667, 128.624063),
		new kakao.maps.LatLng(36.1195987, 128.3443),
		new kakao.maps.LatLng(36.568425, 128.7295375),
		new kakao.maps.LatLng(36.1397714, 128.1136148),
		new kakao.maps.LatLng(35.856242, 129.224784),
		new kakao.maps.LatLng(36.0190333, 129.3433898),
		new kakao.maps.LatLng(35.160032, 126.851338),
		new kakao.maps.LatLng(35.87139, 128.601763),
		new kakao.maps.LatLng(36.3504396, 127.3849508),
		new kakao.maps.LatLng(35.179816, 129.0750223),
		new kakao.maps.LatLng(36.4803512, 127.2894325),
		new kakao.maps.LatLng(35.5394773, 129.3112994),
		new kakao.maps.LatLng(34.833626, 126.351124),
		new kakao.maps.LatLng(34.486818, 126.263475),
		new kakao.maps.LatLng(34.3110391, 126.7548524),
		new kakao.maps.LatLng(35.301943, 126.784814),
		new kakao.maps.LatLng(35.2772127, 126.5120143),
		new kakao.maps.LatLng(35.065929, 126.5165816),
		new kakao.maps.LatLng(34.9904886, 126.4817117),
		new kakao.maps.LatLng(34.8001638, 126.6967961),
		new kakao.maps.LatLng(34.573558, 126.599225),
		new kakao.maps.LatLng(34.64209, 126.7672),
		new kakao.maps.LatLng(34.681622, 126.9070507),
		new kakao.maps.LatLng(35.0645238, 126.9864771),
		new kakao.maps.LatLng(34.771458, 127.080088),
		new kakao.maps.LatLng(34.6047049, 127.275507),
		new kakao.maps.LatLng(35.2025096, 127.4629375),
		new kakao.maps.LatLng(35.2820169, 127.2919779),
		new kakao.maps.LatLng(35.321175, 126.988175),
		new kakao.maps.LatLng(34.9406575, 127.6958987),
		new kakao.maps.LatLng(35.015814, 126.710814),
		new kakao.maps.LatLng(34.9506984, 127.487243),
		new kakao.maps.LatLng(34.760425, 127.662313),
		new kakao.maps.LatLng(34.811875, 126.3923375),
		new kakao.maps.LatLng(35.731755, 126.733199),
		new kakao.maps.LatLng(35.435836, 126.701973),
		new kakao.maps.LatLng(35.374476, 127.137489),
		new kakao.maps.LatLng(35.6178286, 127.2890774),
		new kakao.maps.LatLng(35.647366, 127.5215208),
		new kakao.maps.LatLng(36.00681, 127.660818),
		new kakao.maps.LatLng(35.7917621, 127.424875),
		new kakao.maps.LatLng(35.904708, 127.162019),
		new kakao.maps.LatLng(35.8035917, 126.8808375),
		new kakao.maps.LatLng(35.416432, 127.390438),
		new kakao.maps.LatLng(35.569867, 126.856038),
		new kakao.maps.LatLng(35.948295, 126.957786),
		new kakao.maps.LatLng(35.9676263, 126.736875),
		new kakao.maps.LatLng(35.824171, 127.14805),
		new kakao.maps.LatLng(33.253925, 126.5597875),
		new kakao.maps.LatLng(33.499568, 126.531138),
		new kakao.maps.LatLng(36.74561, 126.297913),
		new kakao.maps.LatLng(36.6808995, 126.8447382),
		new kakao.maps.LatLng(36.601324, 126.660775),
		new kakao.maps.LatLng(36.459151, 126.802238),
		new kakao.maps.LatLng(36.080286, 126.6917418),
		new kakao.maps.LatLng(36.275658, 126.909775),
		new kakao.maps.LatLng(36.108857, 127.488213),
		new kakao.maps.LatLng(36.8899744, 126.6459003),
		new kakao.maps.LatLng(36.274554, 127.248633),
		new kakao.maps.LatLng(36.1872399, 127.0986227),
		new kakao.maps.LatLng(36.7849216, 126.4502766),
		new kakao.maps.LatLng(36.790013, 127.002474),
		new kakao.maps.LatLng(36.333452, 126.612803),
		new kakao.maps.LatLng(36.446556, 127.11904),
		new kakao.maps.LatLng(36.815147, 127.113892),
		new kakao.maps.LatLng(36.984539, 128.365589),
		new kakao.maps.LatLng(36.940282, 127.690487),
		new kakao.maps.LatLng(36.815381, 127.786704),
		new kakao.maps.LatLng(36.85542, 127.435602),
		new kakao.maps.LatLng(36.785345, 127.581507),
		new kakao.maps.LatLng(36.175047, 127.783423),
		new kakao.maps.LatLng(36.3064369, 127.5714191),
		new kakao.maps.LatLng(36.489455, 127.729485),
		new kakao.maps.LatLng(37.132646, 128.191037),
		new kakao.maps.LatLng(36.991105, 127.926012),
		new kakao.maps.LatLng(36.6424987, 127.488975),
		new kakao.maps.LatLng(37.4559418, 126.7051505)
	];

	var infomations = [
		'서울특별시 강동구',
		'서울특별시 송파구',
		'서울특별시 강남구',
		'서울특별시 서초구',
		'서울특별시 관악구',
		'서울특별시 동작구',
		'서울특별시 영등포구',
		'서울특별시 금천구',
		'서울특별시 구로구',
		'서울특별시 강서구',
		'서울특별시 양천구',
		'서울특별시 마포구',
		'서울특별시 서대문구',
		'서울특별시 은평구',
		'서울특별시 노원구',
		'서울특별시 도봉구',
		'서울특별시 강북구',
		'서울특별시 성북구',
		'서울특별시 중랑구',
		'서울특별시 동대문구',
		'서울특별시 광진구',
		'서울특별시 성동구',
		'서울특별시 용산구',
		'서울특별시 중구',
		'서울특별시 종로구',
		'강원도 양양군',
		'강원도 고성군',
		'강원도 인제군',
		'강원도 양구군',
		'강원도 화천군',
		'강원도 철원군',
		'강원도 정선군',
		'강원도 평창군',
		'강원도 영월군',
		'강원도 횡성군',
		'강원도 홍천군',
		'강원도 삼척시',
		'강원도 속초시',
		'강원도 태백시',
		'강원도 동해시',
		'강원도 강릉시',
		'강원도 원주시',
		'강원도 춘천시',
		'경기도 양평군',
		'경기도 가평군',
		'경기도 연천군',
		'경기도 여주시',
		'경기도 포천시',
		'경기도 양주시',
		'경기도 광주시',
		'경기도 화성시',
		'경기도 김포시',
		'경기도 안성시',
		'경기도 이천시',
		'경기도 파주시',
		'경기도 용인시',
		'경기도 하남시',
		'경기도 의왕시',
		'경기도 군포시',
		'경기도 시흥시',
		'경기도 오산시',
		'경기도 남양주시',
		'경기도 구리시',
		'경기도 과천시',
		'경기도 고양시',
		'경기도 안산시',
		'경기도 동두천시',
		'경기도 평택시',
		'경기도 광명시',
		'경기도 부천시',
		'경기도 안양시',
		'경기도 의정부시',
		'경기도 성남시',
		'경기도 수원시',
		'경상남도 합천군',
		'경상남도 거창군',
		'경상남도 함양군',
		'경상남도 산청군',
		'경상남도 하동군',
		'경상남도 남해군',
		'경상남도 고성군',
		'경상남도 창녕군',
		'경상남도 함안군',
		'경상남도 의령군',
		'경상남도 양산시',
		'경상남도 거제시',
		'경상남도 밀양시',
		'경상남도 김해시',
		'경상남도 사천시',
		'경상남도 통영시',
		'경상남도 진주시',
		'경상남도 창원시',
		'경상북도 울릉군',
		'경상북도 울진군',
		'경상북도 봉화군',
		'경상북도 예천군',
		'경상북도 칠곡군',
		'경상북도 성주군',
		'경상북도 고령군',
		'경상북도 청도군',
		'경상북도 영덕군',
		'경상북도 영양군',
		'경상북도 청송군',
		'경상북도 의성군',
		'경상북도 군위군',
		'경상북도 경산시',
		'경상북도 문경시',
		'경상북도 상주시',
		'경상북도 영천시',
		'경상북도 영주시',
		'경상북도 구미시',
		'경상북도 안동시',
		'경상북도 김천시',
		'경상북도 경주시',
		'경상북도 포항시',
		'광주광역시',
		'대구광역시',
		'대전광역시',
		'부산광역시',
		'세종특별자치시',
		'울산광역시',
		'전라남도 신안군',
		'전라남도 진도군',
		'전라남도 완도군',
		'전라남도 장성군',
		'전라남도 영광군',
		'전라남도 함평군',
		'전라남도 무안군',
		'전라남도 영암군',
		'전라남도 해남군',
		'전라남도 강진군',
		'전라남도 장흥군',
		'전라남도 화순군',
		'전라남도 보성군',
		'전라남도 고흥군',
		'전라남도 구례군',
		'전라남도 곡성군',
		'전라남도 담양군',
		'전라남도 광양시',
		'전라남도 나주시',
		'전라남도 순천시',
		'전라남도 여수시',
		'전라남도 목포시',
		'전라북도 부안군',
		'전라북도 고창군',
		'전라북도 순창군',
		'전라북도 임실군',
		'전라북도 장수군',
		'전라북도 무주군',
		'전라북도 진안군',
		'전라북도 완주군',
		'전라북도 김제시',
		'전라북도 남원시',
		'전라북도 정읍시',
		'전라북도 익산시',
		'전라북도 군산시',
		'전라북도 전주시',
		'제주특별자치도 서귀포시',
		'제주특별자치도 제주시',
		'충청남도 태안군',
		'충청남도 예산군',
		'충청남도 홍성군',
		'충청남도 청양군',
		'충청남도 서천군',
		'충청남도 부여군',
		'충청남도 금산군',
		'충청남도 당진시',
		'충청남도 계룡시',
		'충청남도 논산시',
		'충청남도 서산시',
		'충청남도 아산시',
		'충청남도 보령시',
		'충청남도 공주시',
		'충청남도 천안시',
		'충청북도 단양군',
		'충청북도 음성군',
		'충청북도 괴산군',
		'충청북도 진천군',
		'충청북도 증평군',
		'충청북도 영동군',
		'충청북도 옥천군',
		'충청북도 보은군',
		'충청북도 제천시',
		'충청북도 충주시',
		'충청북도 청주시',
		'인천광역시'
	];
	
	var dosiList=[
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'서울',
		'강원',
		'강원',
		'강원',
		'강원',
		'강원',
		'강원',
		'강원',
		'강원',
		'강원',
		'강원',
		'강원',
		'강원',
		'강원',
		'강원',
		'강원',
		'강원',
		'강원',
		'강원',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경기',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'경상',
		'광주',
		'대구',
		'대전',
		'부산',
		'세종',
		'울산',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'전라',
		'제주',
		'제주',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'충청',
		'인천'		
	];
	
	var siList=[
		'강동구',
		'송파구',
		'강남구',
		'서초구',
		'관악구',
		'동작구',
		'영등포구',
		'금천구',
		'구로구',
		'강서구',
		'양천구',
		'마포구',
		'서대문구',
		'은평구',
		'노원구',
		'도봉구',
		'강북구',
		'성북구',
		'중랑구',
		'동대문구',
		'광진구',
		'성동구',
		'용산구',
		'중구',
		'종로구',
		'양양군',
		'고성군',
		'인제군',
		'양구군',
		'화천군',
		'철원군',
		'정선군',
		'평창군',
		'영월군',
		'횡성군',
		'홍천군',
		'삼척시',
		'속초시',
		'태백시',
		'동해시',
		'강릉시',
		'원주시',
		'춘천시',
		'양평군',
		'가평군',
		'연천군',
		'여주시',
		'포천시',
		'양주시',
		'광주시',
		'화성시',
		'김포시',
		'안성시',
		'이천시',
		'파주시',
		'용인시',
		'하남시',
		'의왕시',
		'군포시',
		'시흥시',
		'오산시',
		'남양주시',
		'구리시',
		'과천시',
		'고양시',
		'안산시',
		'동두천시',
		'평택시',
		'광명시',
		'부천시',
		'안양시',
		'의정부시',
		'성남시',
		'수원시',
		'합천군',
		'거창군',
		'함양군',
		'산청군',
		'하동군',
		'남해군',
		'고성군',
		'창녕군',
		'함안군',
		'의령군',
		'양산시',
		'거제시',
		'밀양시',
		'김해시',
		'사천시',
		'통영시',
		'진주시',
		'창원시',
		'울릉군',
		'울진군',
		'봉화군',
		'예천군',
		'칠곡군',
		'성주군',
		'고령군',
		'청도군',
		'영덕군',
		'영양군',
		'청송군',
		'의성군',
		'군위군',
		'경산시',
		'문경시',
		'상주시',
		'영천시',
		'영주시',
		'구미시',
		'안동시',
		'김천시',
		'경주시',
		'포항시',
		'광주시',
		'대구시',
		'대전시',
		'부산시',
		'세종시',
		'울산시',
		'신안군',
		'진도군',
		'완도군',
		'장성군',
		'영광군',
		'함평군',
		'무안군',
		'영암군',
		'해남군',
		'강진군',
		'장흥군',
		'화순군',
		'보성군',
		'고흥군',
		'구례군',
		'곡성군',
		'담양군',
		'광양시',
		'나주시',
		'순천시',
		'여수시',
		'목포시',
		'부안군',
		'고창군',
		'순창군',
		'임실군',
		'장수군',
		'무주군',
		'진안군',
		'완주군',
		'김제시',
		'남원시',
		'정읍시',
		'익산시',
		'군산시',
		'전주시',
		'서귀포시',
		'제주시',
		'태안군',
		'예산군',
		'홍성군',
		'청양군',
		'서천군',
		'부여군',
		'금산군',
		'당진시',
		'계룡시',
		'논산시',
		'서산시',
		'아산시',
		'보령시',
		'공주시',
		'천안시',
		'단양군',
		'음성군',
		'괴산군',
		'진천군',
		'증평군',
		'영동군',
		'옥천군',
		'보은군',
		'제천시',
		'충주시',
		'청주시',
		'인천시'
	];
	
	// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
	var bounds = new kakao.maps.LatLngBounds();    
	
	// 마커와 인포윈도우 객체 배열 생성
	let markers = [];
	let infowindows = [];

	for (let i = 0; i < points.length; i++) {
	    // 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
	    let marker = new kakao.maps.Marker({
	    	position : points[i],
	    	map:map
	    });
	    
	    markers.push(marker); // 마커배열 추가
	    
	    // 마커 클릭 이벤트 추가 (routeBoardId를 이용하여 URL로 이동)
    	// kakao.maps.event.addListener(marker, 'click', makeClickListener(marker, i));
    	
        // 마우스가 마커 위에 올라갈 때 정보창을 표시하는 이벤트
        kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infomations[i], dosiList[i], siList[i], i));

        // 마우스가 마커에서 벗어났을 때 정보창을 닫는 이벤트
        kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(marker, i));
	    
	    // LatLngBounds 객체에 좌표를 추가합니다
	    bounds.extend(points[i]);
	}
	
	// 지도의 범위를 재설정
	// map.setBounds(bounds);
	
//	// 클릭 이벤트 리스너 생성
//	function makeClickListener(marker, index) {
//	    return function() {
//	
//	        // GET 방식으로 URL 전송
//	        if (routeBoardId) {
//	            // 예: /destinationPage?routeBoardId=123 이런식으로 전송
//	            var targetUrl = 'routedetail.do?no=' + routeBoardId;
//	            window.location.href = targetUrl;  // GET 방식으로 URL 이동
//	        } else {
//	            console.log("routeBoardId가 없습니다.");
//	        }
//	    };
//	}
	
    // 마우스 오버 시 서버에 요청하고 인포윈도우를 표시하는 리스너 생성
    function makeOverListener(map, marker, infomation, dosiValue, siValue, index) {
        return function () {
            // AJAX 요청으로 서버에 데이터를 보냅니다
            $.ajax({
                type: 'POST', // POST 또는 GET
                url: 'mainmap.do', // 서버의 URL
                data: {
                	local: infomation,  // 예: '서울특별시 성동구'
                    dosi: dosiValue,    // 예: '서울'
                    si: siValue     // 예: '강동구'
                },
                success: function (response) {
                	// 불러온데이터 parse실행
                	const jsonData=JSON.parse(decodeURIComponent(response));
                	console.log("jsonData : ",jsonData);
					// 변수지정
					let local, placeCount, error, routeBoardId, title, content, transport, ofile1, rfile1;
					
					if (jsonData.local != null) {
					    local = jsonData.local.replace(/\+/gi, ' ');
					}
					
					if (jsonData.placeCount != null) {
					    placeCount = jsonData.placeCount;
					}
					
					if (jsonData.error != null) {
					    error = jsonData.error.replace(/\+/gi, ' ');
					}
					
					if (jsonData.routeBoardId != null) {
					    routeBoardId = jsonData.routeBoardId.replace(/\+/gi, ' ');
					}
					
					if (jsonData.title != null) {
					    title = jsonData.title.replace(/\+/gi, ' ');
					}
					
					if (jsonData.content != null) {
					    content = jsonData.content.replace(/\+/gi, ' ');
					}
					if (jsonData.transport != null) {
					    transport = jsonData.transport.replace(/\+/gi, ' ');
					}
					
					if (jsonData.ofile1 != null) {
					    ofile1 = jsonData.ofile1.replace(/\+/gi, ' ');
					}
					
					if (jsonData.rfile1 != null) {
					    rfile1 = jsonData.rfile1.replace(/\+/gi, ' ');
					}
                	
                	
                    // 서버로부터 받은 데이터로 인포윈도우 내용 변경
                    let pop = '';
                     
                    // 오류가 있는지 확인
                    if (error==""){
                		console.log("content : ",content);
                    	pop = '<div style="padding:10px;display: flex; justify-content: space-between; align-items: flex-start;">여행지 등록수 : '+placeCount+'<br>'+title+'<br>'+transport+'<br>'+content;
            	        // ofile1과 rfile1이 있을 경우 이미지 태그 추가
				        if (rfile1) {
				            let imgTag = '<br><img src="'+contextPath+'/resources/route_upfiles/' + rfile1 + '" alt="' + ofile1 + '" style="width:200px;height:auto;float:right;">';
				            console.log(imgTag);
				            pop += imgTag;
				        }
				        
				        pop += '</div>';                    	
                    } else{
                    	pop = '<div style="padding:10px;width:200px;">여행지 등록수 : '+placeCount+'<br>'+error+'</div>';                    	
                    }
                    
                    // 인포윈도우 생성 및 열기
                    let infowindow = new kakao.maps.InfoWindow({
                        content: pop // 서버로부터 받은 데이터를 표시
                    });
                    infowindow.open(map, marker);
                    
                    // 마커에 인포윈도우를 저장하여 나중에 참조
                    infowindows[index] = infowindow;
                    
                    // **여기서 클릭 이벤트 추가하여 routeBoardId 사용 가능**
                    kakao.maps.event.addListener(marker, 'click', function() {
                        if (routeBoardId) {
                            // GET 방식으로 URL 전송
                            let targetUrl = 'routedetail.do?no=' + routeBoardId;
                            window.location.href = targetUrl;  // GET 방식으로 URL 이동
                        } else {
                            console.log("routeBoardId가 없습니다.");
                        }
                    });                    
                    
                },
                error: function (error) {
                    console.error('Error fetching data:', error);
                }
            });
        };
    }
 
    // 마우스 아웃 시 인포윈도우를 닫는 리스너 생성
    function makeOutListener(marker,index) {
        return function() {
        	// 마커에 저장된 인포 윈도우가 있을 경우 닫기
        	if (infowindows[index]){
            	infowindows[index].close(); // 마우스 아웃 시 정보창을 닫는다
            }
        };
    }
}
