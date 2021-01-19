@extends('admin-template')
@section('content')
        <!-- Page-Title -->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="page-title-box">
                            <div class="btn-group pull-right">
                                <ol class="breadcrumb hide-phone p-0 m-0">
                                    <li class="breadcrumb-item"><a href="{{ route('admin.dashboard') }}">LPFK BJB</a></li>
                                    <li class="breadcrumb-item active">Dashboard</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Selamat Datang !</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card-box">
                            <div id="main" style="height:700px;"></div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card-box">
                            <div id="maincorp" style="height:1200px;"></div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card-box">
                            <div id="maincorp2" style="height:1200px;"></div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card-box">
                            <div id="maincorp3" style="height:1200px;"></div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card-box">
                            <div id="maincorp4" style="height:1200px;"></div>
                        </div>
                    </div>
                </div>

<script>    
  
var geoCoordMap = {
'LANDAK': [ 109.77883787995307, 0.553906608077137 ] ,
'SAMBAS': [ 109.34570906136244, 1.424064060935804 ] ,
'SANGGAU': [ 110.45794130380932, 0.250817438213368 ] ,
'KETAPANG': [ 110.61223469989454, -1.632341854700171 ] ,
'SINTANG': [ 112.0665288949543, 0.094874966823964 ] ,
'MELAWI': [ 111.72467686609947, -0.64398756158521 ] ,
'KAYONG UTARA': [ 110.10078643651772, -1.051320817578975 ] ,
'KAPUAS': [ 114.32630243835753, -1.811039485978313 ] ,
'SERUYAN': [ 112.17969817331877, -2.336070863023746 ] ,
'BARITO UTARA': [ 115.10813611918687, -0.979362648975988 ] ,
'SUKAMARA': [ 111.17206073306362, -2.558790658346138 ] ,
'LAMANDAU': [ 111.30981741200034, -1.7287134084472 ] ,
'KATINGAN': [ 113.04552584499605, -1.673612030940804 ] ,
'PULANG PISAU': [ 113.96345327804612, -2.759739509976482 ] ,
'KOTABARU': [ 116.04828141778914, -2.714802135833427 ] ,
'BANJAR': [ 115.08628154391872, -3.314891174939425 ] ,
'TAPIN': [ 115.04423541683849, -2.906262129676629 ] ,
'HULU SUNGAI TENGAH': [ 115.4238729190528, -2.613990600306923 ] ,
'TANAH BUMBU': [ 115.67113743321509, -3.379401441078844 ] ,
'BALANGAN': [ 115.6158203113509, -2.340443357748125 ] ,
'KUTAI TIMUR': [ 116.771, 1.211 ] ,
'BERAU': [ 117.30530416625155, 1.918075645408059 ] ,
'BULUNGAN': [ 117.0327428105502, 2.762253647682589 ] ,
'NUNUKAN': [ 116.59702740228299, 3.9540876978198 ] ,
'HULU SUNGAI UTARA': [ 115.13146272084231, -2.438216066284743 ] ,
'BANJARBARU': [ 114.79282551118418, -3.467778972738382 ] ,
'BALIKPAPAN': [ 116.87899382247429, -1.163047934588579 ] ,
'KAPUAS HULU': [ 112.80593914454761, 0.830580409090288 ] ,
'HULU SUNGAI SELATAN': [ 115.20014778413783, -2.723112198667206 ] ,
'SINGKAWANG': [ 109.03019941940407, 0.887304371768833 ] ,
'KUTAI BARAT': [ 115.29707923074908, 0.243660397731886 ] ,
'KOTAWARINGIN BARAT': [ 111.73945440104056, -2.406182739517427 ] ,
'TANAH LAUT': [ 114.90487461934843, -3.818258045182654 ] ,
'BARITO SELATAN': [ 114.84962850242526, -1.841337007883026 ] ,
'KOTAWARINGIN TIMUR': [ 112.6774550369026, -2.072638438413657 ] ,
'PENAJAM PASER UTARA': [ 116.547, -1.037 ] ,
'BARITO KUALA': [ 114.61606167448569, -3.090162393114984 ] ,
'BARITO TIMUR': [ 115.0959661191296, -1.927311009569383 ] ,
'KUBU RAYA': [ 109.55942284274994, -0.37043537268884 ] ,
'PALANGKA RAYA': [ 113.75747514407517, -1.806352622450803 ] ,
'SEKADAU': [ 110.98530248799061, -0.009629747096066 ] ,
'TABALONG': [ 115.48608103039575, -1.884859393420012 ] ,
'GUNUNG MAS': [ 113.52341100003038, -0.955302892215984 ] ,
'BONTANG': [ 117.34931752602982, 0.210607849926072 ] ,
'KOTA PONTIANAK': [ 109.3538759340279, -0.070622137941333 ] ,
'SAMARINDA': [ 117.18383800918785, -0.433625016239915 ] ,
'BANJARMASIN': [ 114.57973545541473, -3.337790885991844 ] ,
'TANA TIDUNG': [ 117.14180449834338, 3.452758651077356 ] ,
'TARAKAN': [ 117.60038131506319, 3.353554993179628 ] ,
'PASER': [ 116.054, -1.559 ] ,
'BENGKAYANG': [ 109.5746104971013, 1.015797443889054 ] ,
'MEMPAWAH': [ 109.17391247842124, 0.331069805577334 ] ,
'MURUNG RAYA': [ 114.27356586326481, -0.028759839745458 ] ,
'KUTAI KERTANEGARA': [ 116.5475867146705, 0.125324071048293 ] ,
'MALINAU': [ 115.72032711230115, 2.46621081597755 ] ,
'MAHAKAM ULU': [ 114.426, 1.116 ]
};

var geoCoordMap2 = {
'KALIMANTAN BARAT': [ 110.20428467, -3.06762958 ] ,
'KALIMANTAN SELATAN': [ 115.67458344, -4.72921658 ] ,
'KALIMANTAN UTARA': [ 117.11810303, 2.74987674 ] ,
'KALIMANTAN TENGAH': [ 115.29113007, -2.22389984 ] ,
'KALIMANTAN TIMUR': [ 116.46150208, -2.19153571 ] 
};

var convertData = function (data) {
    var res = [];
    for (var i = 0; i < data.length; i++) {
        var geoCoord = geoCoordMap[data[i].name];
        if (geoCoord) {
            res.push({
                name: data[i].name+'. '+ data[i].value+'/'+data[i].x+'',
               //name:data[i].value+'/'+data[i].x,
                value: geoCoord.concat(data[i].value)
              
            });
        }
    }
    return res;
};

var maindata = [
                {NAME_0: "Indonesia",name:"", value:"0", value2:"3",x:"3"},
                {NAME_0: "Indonesia",name:"KALIMANTAN SELATAN", value:"282",value2:"0",x:"0"},
                {NAME_0: "Indonesia",name:"KALIMANTAN TIMUR", value:"130",value2:"0",x:"0"},
                {NAME_0: "Indonesia",name:"KALIMANTAN TENGAH", value:"56",value2:"0",x:"0"},
                {NAME_0: "Indonesia",name:"KALIMANTAN UTARA", value:"15",value2:"0",x:"0"},
            ];

main_option = {
    title : {
        text: 'Jumlah Fasyankes Terlayani di Kalimantan',
        subtext: 'Tahun 2019',
        left: 'center'
    },
    tooltip : {
        trigger: 'item',
         formatter: function (params) {
            var value = (params.name + '').split('.');
            return params.seriesName + '<br/>' +value[0]+'('+value[1]+')';
        }
    },
    
    // visualMap: {
 
    //     pieces: [
    //             {min: 1,color: '#02d116',label:'Terlayani'},
    //             {max: 1, label: 'Belum Terlayani', color: 'red'}
                
    //         ]
    //         },
      toolbox: {
                        left: '2%',
                        showTitle:true,
                        orient:'horizontal',
                        feature: {
                            dataView: {
                            show: true,
                            title: "Text View",
                            lang: [
                            "Text View",
                            "Close",
                            "Refresh",
                                ],
                            readOnly: false
                                },
                           
                            saveAsImage: {
                            title: "Save Image",
                            pixelRatio:5
                            },
                             restore: {
                             show: true,
                             title: "Restore"
                             },
                            }
                        },
    geo: {
        map: 'Kalimantan',
        label: {
            normal: {
                show: true,
                textStyle: {
                    color: 'rgba(0,0,0,0.4)'
                }
            }
        },
        aspectScale:0.95,
        roam: true,
        itemStyle: {
            normal: {
                areaColor: '#ccedfc',//'#323c48',
                borderColor: '#111'
            },
            emphasis: {
                areaColor: '#f1a7f2'
            }
        }
    },
    series : [
            {
            name: 'Indonesia',
        
            type: 'effectScatter',
            coordinateSystem: 'geo',
            //symbolSize: 12,
             symbolSize: function (val) {
               return (val[2] % 11)+10;
                
            },
            label: {
                fontFamily: 'sans-serif',
                fontSize:8,
                normal: {
                    formatter: function (params) {
                        var value = (params.name + '').split('.');
                        value = value[1];
                        return value;
                    },

                    position: 'inside',
                    show: true
                },
                emphasis: {
                    show: true
                }
            },
            itemStyle: {
                emphasis: {
                    borderColor: '#fff',
                    borderWidth: 1
                }
            },
            data:[0]
        }
    ]
};

var main_myChart = echarts.init(document.getElementById('main'), null, {
    renderer: 'canvas'
});

main_myChart.showLoading();
main_myChart.setOption(main_option);


main_myChart.hideLoading();
main_myChart.setOption({
  series: [{
    name: 'Indonesia',
    type: 'effectScatter',
    data: convertData(maindata)
  }]
});
// BATAS
var data = [
                {prop:"", name:"", value:"0", value2:"3",x:"3"},
                {prop:"KALIMANTAN SELATAN", name:"BANJARMASIN", value:"41", value2:"1",x:"40"},
                {prop:"KALIMANTAN SELATAN", name:"BANJARBARU", value:"12", value2:"1",x:"11"},
                {prop:"KALIMANTAN SELATAN", name:"BALANGAN", value:"4", value2:"1",x:"12"},
                {prop:"KALIMANTAN SELATAN", name:"TANAH BUMBU", value:"13", value2:"15",x:"15"},
                {prop:"KALIMANTAN SELATAN", name:"TABALONG", value:"19", value2:"1",x:"18"},
                {prop:"KALIMANTAN SELATAN", name:"HULU SUNGAI UTARA", value:"16", value2:"1",x:"14"},
                {prop:"KALIMANTAN SELATAN", name:"HULU SUNGAI TENGAH", value:"20", value2:"1",x:"20"},
                {prop:"KALIMANTAN SELATAN", name:"HULU SUNGAI SELATAN", value:"18", value2:"1",x:"23"},
                {prop:"KALIMANTAN SELATAN", name:"TAPIN", value:"1", value2:"16",x:"14"},
                {prop:"KALIMANTAN SELATAN", name:"BARITO KUALA", value:"20", value2:"1",x:"20"},
                {prop:"KALIMANTAN SELATAN", name:"BANJAR", value:"25", value2:"1",x:"30"},
                {prop:"KALIMANTAN SELATAN", name:"KOTABARU", value:"15", value2:"1",x:"29"},
                {prop:"KALIMANTAN SELATAN", name:"TANAH LAUT", value:"23", value2:"1",x:"21"},
            ];

option = {
    title : {
        text: 'Jumlah Fasyankes Terlayani Provinsi Kalimantan Selatan',
        subtext: 'Tahun 2019',
        left: 'center'
    },
    tooltip : {
        trigger: 'item',
         formatter: function (params) {
            var value = (params.name + '').split('.');
            return params.seriesName + '<br/>' +value[0]+'('+value[1]+')';
        }
    },
    
    visualMap: {
 
        pieces: [
                {min: 1,color: '#02d116',label:'Terlayani'},
                {max: 1, label: 'Belum Terlayani', color: 'red'}
                
            ]
            },
      toolbox: {
                        left: '2%',
                        showTitle:true,
                        orient:'horizontal',
                        feature: {
                            dataView: {
                            show: true,
                            title: "Text View",
                            lang: [
                            "Text View",
                            "Close",
                            "Refresh",
                                ],
                            readOnly: false
                                },
                           
                            saveAsImage: {
                            title: "Save Image",
                            pixelRatio:5
                            },
                             restore: {
                             show: true,
                             title: "Restore"
                             },
                            }
                        },
    geo: {
        map: 'provinsi_kalsel',
        label: {
            normal: {
                show: true,
                textStyle: {
                    color: 'rgba(0,0,0,0.4)'
                }
            }
        },
        aspectScale:0.95,
        roam: true,
        itemStyle: {
            normal: {
                areaColor: '#ccedfc',//'#323c48',
                borderColor: '#111'
            },
            emphasis: {
                areaColor: '#f1a7f2'
            }
        }
    },
    series : [
            {
            name: 'Indonesia',
        
            type: 'effectScatter',
            coordinateSystem: 'geo',
            //symbolSize: 12,
             symbolSize: function (val) {
               return (val[2] % 11)+10;
                
            },
            label: {
                fontFamily: 'sans-serif',
                fontSize:8,
                normal: {
                    formatter: function (params) {
            var value = (params.name + '').split('.');
            value = value[1];
            return value;
                    },

                    position: 'inside',
                    show: true
                },
                emphasis: {
                    show: true
                }
            },
            itemStyle: {
                emphasis: {
                    borderColor: '#fff',
                    borderWidth: 1
                }
            },
            data:[0]
        }
    ]
};

var myChart = echarts.init(document.getElementById('maincorp'), null, {
    renderer: 'canvas'
});

myChart.showLoading();
myChart.setOption(option);


myChart.hideLoading();
myChart.setOption({
  series: [{
    name: 'Indonesia',
    type: 'effectScatter',
    data: convertData(data)
  }]
});

// batas
var data2 = [
                {prop:"", name:"", value:"0", value2:"3",x:"3"},
                {prop:"KALIMANTAN TIMUR", name:"BALIKPAPAN", value:"34", value2:"1",x:"40"},
                {prop:"KALIMANTAN TIMUR", name:"SAMARINDA", value:"3", value2:"1",x:"39"},
                {prop:"KALIMANTAN TIMUR", name:"BALIKPAPAN", value:"34", value2:"1",x:"40"},
                {prop:"KALIMANTAN TIMUR", name:"BONTANG", value:"5", value2:"15",x:"11"},
                {prop:"KALIMANTAN TIMUR", name:"PASER", value:"3", value2:"1",x:"18"},
                {prop:"KALIMANTAN TIMUR", name:"MAHAKAM ULU", value:"0", value2:"1",x:"5"},
                {prop:"KALIMANTAN TIMUR", name:"PENAJAM PASER UTARA", value:"0", value2:"1",x:"12"},
                {prop:"KALIMANTAN TIMUR", name:"BERAU", value:"20", value2:"1",x:"18"},
                {prop:"KALIMANTAN TIMUR", name:"KUTAI TIMUR", value:"1", value2:"1",x:"26"},
                {prop:"KALIMANTAN TIMUR", name:"KUTAI KERTANEGARA", value:"0", value2:"1",x:"46"},
                {prop:"KALIMANTAN TIMUR", name:"KUTAI BARAT", value:"19", value2:"1",x:"19"},
            ];
option2 = {
    title : {
        text: 'Jumlah Fasyankes Terlayani Provinsi Kalimantan Timur',
        subtext: 'Tahun 2019',
        left: 'center'
    },
    tooltip : {
        trigger: 'item',
         formatter: function (params) {
            var value = (params.name + '').split('.');
            return params.seriesName + '<br/>' +value[0]+'('+value[1]+')';
        }
    },
    
    visualMap: {
 
        pieces: [
                {min: 1,color: '#02d116',label:'Terlayani'},
                {max: 1, label: 'Belum Terlayani', color: 'red'}
                
            ]
            },
      toolbox: {
                        left: '2%',
                        showTitle:true,
                        orient:'horizontal',
                        feature: {
                            dataView: {
                            show: true,
                            title: "Text View",
                            lang: [
                            "Text View",
                            "Close",
                            "Refresh",
                                ],
                            readOnly: false
                                },
                           
                            saveAsImage: {
                            title: "Save Image",
                            pixelRatio:5
                            },
                             restore: {
                             show: true,
                             title: "Restore"
                             },
                            }
                        },
    geo: {
        map: 'provinsi_kaltim',
        label: {
            normal: {
                show: true,
                textStyle: {
                    color: 'rgba(0,0,0,0.4)'
                }
            }
        },
        aspectScale:0.95,
        roam: true,
        itemStyle: {
            normal: {
                areaColor: '#ccedfc',//'#323c48',
                borderColor: '#111'
            },
            emphasis: {
                areaColor: '#f1a7f2'
            }
        }
    },
    series : [
            {
            name: 'Indonesia',
        
            type: 'effectScatter',
            coordinateSystem: 'geo',
            //symbolSize: 12,
             symbolSize: function (val) {
               return (val[2] % 11)+10;
                
            },
            label: {
                fontFamily: 'sans-serif',
                fontSize:8,
                normal: {
                    formatter: function (params) {
            var value = (params.name + '').split('.');
            value = value[1];
            return value;
                    },

                    position: 'inside',
                    show: true
                },
                emphasis: {
                    show: true
                }
            },
            itemStyle: {
                emphasis: {
                    borderColor: '#fff',
                    borderWidth: 1
                }
            },
            data:[0]
        }
    ]
};

var myChart2 = echarts.init(document.getElementById('maincorp2'), null, {
    renderer: 'canvas'
});

myChart2.showLoading();
myChart2.setOption(option2);


myChart2.hideLoading();
myChart2.setOption({
  series: [{
    name: 'Indonesia',
    type: 'effectScatter',
    data: convertData(data2)
  }]
});
// batas
var data3 = [
                {prop:"", name:"", value:"0", value2:"3",x:"3"},
                {prop:"KALIMANTAN TENGAH", name:"PALANGKA RAYA", value:"6", value2:"1",x:"15"},
                {prop:"KALIMANTAN TENGAH", name:"BARITO SELATAN", value:"2", value2:"1",x:"13"},
                {prop:"KALIMANTAN TENGAH", name:"KAPUAS", value:"1", value2:"1",x:"27"},
                {prop:"KALIMANTAN TENGAH", name:"KOTAWARINGIN TIMUR", value:"16", value2:"15",x:"21"},
                {prop:"KALIMANTAN TENGAH", name:"KOTAWARINGIN BARAT", value:"0", value2:"1",x:"17"},
                {prop:"KALIMANTAN TENGAH", name:"BARITO UTARA", value:"1", value2:"1",x:"17"},
                {prop:"KALIMANTAN TENGAH", name:"SUKAMARA", value:"1", value2:"1",x:"12"},
                {prop:"KALIMANTAN TENGAH", name:"LAMANDAU", value:"20", value2:"1",x:"18"},
                {prop:"KALIMANTAN TENGAH", name:"KATINGAN", value:"1", value2:"1",x:"17"},
                {prop:"KALIMANTAN TENGAH", name:"PULANG PISAU", value:"2", value2:"1",x:"13"},
                {prop:"KALIMANTAN TENGAH", name:"GUNUNG MAS", value:"11", value2:"1",x:"16"},
                {prop:"KALIMANTAN TENGAH", name:"BARITO TIMUR", value:"0", value2:"1",x:"12"},
                {prop:"KALIMANTAN TENGAH", name:"MURUNG RAYA", value:"0", value2:"1",x:"15"},
                {prop:"KALIMANTAN TENGAH", name:"SERUYAN", value:"11", value2:"0",x:"14"},
            ];

option3 = {
    title : {
        text: 'Jumlah Fasyankes Terlayani Provinsi Kalimantan Tengah',
        subtext: 'Tahun 2019',
        left: 'center'
    },
    tooltip : {
        trigger: 'item',
         formatter: function (params) {
            var value = (params.name + '').split('.');
            return params.seriesName + '<br/>' +value[0]+'('+value[1]+')';
        }
    },
    
    visualMap: {
 
        pieces: [
                {min: 1,color: '#02d116',label:'Terlayani'},
                {max: 1, label: 'Belum Terlayani', color: 'red'}
                
            ]
            },
      toolbox: {
                        left: '2%',
                        showTitle:true,
                        orient:'horizontal',
                        feature: {
                            dataView: {
                            show: true,
                            title: "Text View",
                            lang: [
                            "Text View",
                            "Close",
                            "Refresh",
                                ],
                            readOnly: false
                                },
                           
                            saveAsImage: {
                            title: "Save Image",
                            pixelRatio:5
                            },
                             restore: {
                             show: true,
                             title: "Restore"
                             },
                            }
                        },
    geo: {
        map: 'provinsi_kalteng',
        label: {
            normal: {
                show: true,
                textStyle: {
                    color: 'rgba(0,0,0,0.4)'
                }
            }
        },
        aspectScale:0.95,
        roam: true,
        itemStyle: {
            normal: {
                areaColor: '#ccedfc',//'#323c48',
                borderColor: '#111'
            },
            emphasis: {
                areaColor: '#f1a7f2'
            }
        }
    },
    series : [
            {
            name: 'Indonesia',
        
            type: 'effectScatter',
            coordinateSystem: 'geo',
            //symbolSize: 12,
             symbolSize: function (val) {
               return (val[2] % 11)+10;
                
            },
            label: {
                fontFamily: 'sans-serif',
                fontSize:8,
                normal: {
                    formatter: function (params) {
            var value = (params.name + '').split('.');
            value = value[1];
            return value;
                    },

                    position: 'inside',
                    show: true
                },
                emphasis: {
                    show: true
                }
            },
            itemStyle: {
                emphasis: {
                    borderColor: '#fff',
                    borderWidth: 1
                }
            },
            data:[0]
        }
    ]
};

var myChart3 = echarts.init(document.getElementById('maincorp3'), null, {
    renderer: 'canvas'
});

myChart3.showLoading();
myChart3.setOption(option3);


myChart3.hideLoading();
myChart3.setOption({
  series: [{
    name: 'Indonesia',
    type: 'effectScatter',
    data: convertData(data3)
  }]
});
// batas
var data4 = [
                {prop:"", name:"", value:"0", value2:"3",x:"3"},
                {prop:"KALIMANTAN UTARA", name:"TARAKAN", value:"0", value2:"1",x:"10"},
                {prop:"KALIMANTAN UTARA", name:"MALINAU", value:"15", value2:"1",x:"15"},
                {prop:"KALIMANTAN UTARA", name:"BULUNGAN", value:"0", value2:"1",x:"14"},
                {prop:"KALIMANTAN UTARA", name:"NUNUKAN", value:"0", value2:"15",x:"14"},
                {prop:"KALIMANTAN UTARA", name:"TANA TIDUNG", value:"0", value2:"1",x:"5"},
            ];

option4 = {
    title : {
        text: 'Jumlah Fasyankes Terlayani Provinsi Kalimantan Utara',
        subtext: 'Tahun 2019',
        left: 'center'
    },
    tooltip : {
        trigger: 'item',
         formatter: function (params) {
            var value = (params.name + '').split('.');
            return params.seriesName + '<br/>' +value[0]+'('+value[1]+')';
        }
    },
    
    visualMap: {
 
        pieces: [
                {min: 1,color: '#02d116',label:'Terlayani'},
                {max: 1, label: 'Belum Terlayani', color: 'red'}
                
            ]
            },
      toolbox: {
                        left: '2%',
                        showTitle:true,
                        orient:'horizontal',
                        feature: {
                            dataView: {
                            show: true,
                            title: "Text View",
                            lang: [
                            "Text View",
                            "Close",
                            "Refresh",
                                ],
                            readOnly: false
                                },
                           
                            saveAsImage: {
                            title: "Save Image",
                            pixelRatio:5
                            },
                             restore: {
                             show: true,
                             title: "Restore"
                             },
                            }
                        },
    geo: {
        map: 'provinsi_kaltara',
        label: {
            normal: {
                show: true,
                textStyle: {
                    color: 'rgba(0,0,0,0.4)'
                }
            }
        },
        aspectScale:0.95,
        roam: true,
        itemStyle: {
            normal: {
                areaColor: '#ccedfc',//'#323c48',
                borderColor: '#111'
            },
            emphasis: {
                areaColor: '#f1a7f2'
            }
        }
    },
    series : [
            {
            name: 'Indonesia',
        
            type: 'effectScatter',
            coordinateSystem: 'geo',
            //symbolSize: 12,
             symbolSize: function (val) {
               return (val[2] % 11)+10;
                
            },
            label: {
                fontFamily: 'sans-serif',
                fontSize:8,
                normal: {
                    formatter: function (params) {
            var value = (params.name + '').split('.');
            value = value[1];
            return value;
                    },

                    position: 'inside',
                    show: true
                },
                emphasis: {
                    show: true
                }
            },
            itemStyle: {
                emphasis: {
                    borderColor: '#fff',
                    borderWidth: 1
                }
            },
            data:[0]
        }
    ]
};

var myChart4 = echarts.init(document.getElementById('maincorp4'), null, {
    renderer: 'canvas'
});

myChart4.showLoading();
myChart4.setOption(option4);


myChart4.hideLoading();
myChart4.setOption({
  series: [{
    name: 'Indonesia',
    type: 'effectScatter',
    data: convertData(data4)
  }]
});
</script>
@stop
