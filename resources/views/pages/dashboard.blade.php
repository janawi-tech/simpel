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
                    <div class="col-xs-12 col-md-6 col-lg-6 col-xl-3">
                        <div class="card-box tilebox-one">
                            <i class="fi-box float-right"></i>
                            <h6 class="text-muted text-uppercase mb-3">Jumlah Permintaan</h6>
                            <h4 class="mb-3" data-plugin="counterup">{{ $jumorder }}</h4>
                        </div>
                    </div>

                    <div class="col-xs-12 col-md-6 col-lg-6 col-xl-3">
                        <div class="card-box tilebox-one">
                            <i class="fi-layers float-right"></i>
                            <h6 class="text-muted text-uppercase mb-3">Jumlah Alat</h6>
                            <h4 class="mb-3"><span data-plugin="counterup">{{ $jumalat }}</span></h4>
                        </div>
                    </div>

                    <div class="col-xs-12 col-md-6 col-lg-6 col-xl-3">
                        <div class="card-box tilebox-one">
                            <i class="fi-tag float-right"></i>
                            <h6 class="text-muted text-uppercase mb-3">Telah Diserahkan</h6>
                            <h4 class="mb-3"><span data-plugin="counterup">{{ $jumselesai }}</span></h4>
                        </div>
                    </div>

                    <div class="col-xs-12 col-md-6 col-lg-6 col-xl-3">
                        <div class="card-box tilebox-one">
                            <i class="fi-briefcase float-right"></i>
                            <h6 class="text-muted text-uppercase mb-3">Belum Diserahkan</h6>
                            <h4 class="mb-3" data-plugin="counterup">{{ $jumbelum }}</h4>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="card-box">
                            <div id="mainb" style="height:500px;"></div> 
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="card-box">
                            <div id="echart_pie2" style="height:400px;"></div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card-box">
                            <div id="maincorp" style="height:400px;"></div>
                        </div>
                    </div>
                </div>

<script>    
    var theme = {
          color: [
              '#ef3845','#26B99A', '#34495E', '#BDC3C7', '#3498DB',
              '#9B59B6', '#8abb6f', '#759c6a', '#bfd3b7','#f08890','#76799d'
          ],

          title: {
              itemGap: 8,
              textStyle: {
                  fontWeight: 'normal',
                  color: '#408829'
              }
          },

          dataRange: {
              color: ['#1f610a', '#97b58d']
          },

          toolbox: {
              color: ['#408829', '#408829', '#408829', '#408829']
          },

          tooltip: {
              backgroundColor: 'rgba(0,0,0,0.5)',
              axisPointer: {
                  type: 'line',
                  lineStyle: {
                      color: '#408829',
                      type: 'dashed'
                  },
                  crossStyle: {
                      color: '#408829'
                  },
                  shadowStyle: {
                      color: 'rgba(200,200,200,0.3)'
                  }
              }
          },

          dataZoom: {
              dataBackgroundColor: '#eee',
              fillerColor: 'rgba(64,136,41,0.2)',
              handleColor: '#408829'
          },
          grid: {
              borderWidth: 0
          },

          categoryAxis: {
              axisLine: {
                  lineStyle: {
                      color: '#408829'
                  }
              },
              splitLine: {
                  lineStyle: {
                      color: ['#eee']
                  }
              }
          },

          valueAxis: {
              axisLine: {
                  lineStyle: {
                      color: '#408829'
                  }
              },
              splitArea: {
                  show: true,
                  areaStyle: {
                      color: ['rgba(250,250,250,0.1)', 'rgba(200,200,200,0.1)']
                  }
              },
              splitLine: {
                  lineStyle: {
                      color: ['#eee']
                  }
              }
          },
          timeline: {
              lineStyle: {
                  color: '#408829'
              },
              controlStyle: {
                  normal: {color: '#408829'},
                  emphasis: {color: '#408829'}
              }
          },

          k: {
              itemStyle: {
                  normal: {
                      color: '#68a54a',
                      color0: '#a9cba2',
                      lineStyle: {
                          width: 1,
                          color: '#408829',
                          color0: '#86b379'
                      }
                  }
              }
          },
          map: {
              itemStyle: {
                  normal: {
                      areaStyle: {
                          color: '#ddd'
                      },
                      label: {
                          textStyle: {
                              color: '#c12e34'
                          }
                      }
                  },
                  emphasis: {
                      areaStyle: {
                          color: '#99d2dd'
                      },
                      label: {
                          textStyle: {
                              color: '#c12e34'
                          }
                      }
                  }
              }
          },
          force: {
              itemStyle: {
                  normal: {
                      linkStyle: {
                          strokeColor: '#408829'
                      }
                  }
              }
          },
          chord: {
              padding: 4,
              itemStyle: {
                  normal: {
                      lineStyle: {
                          width: 1,
                          color: 'rgba(128, 128, 128, 0.5)'
                      },
                      chordStyle: {
                          lineStyle: {
                              width: 1,
                              color: 'rgba(128, 128, 128, 0.5)'
                          }
                      }
                  },
                  emphasis: {
                      lineStyle: {
                          width: 1,
                          color: 'rgba(128, 128, 128, 0.5)'
                      },
                      chordStyle: {
                          lineStyle: {
                              width: 1,
                              color: 'rgba(128, 128, 128, 0.5)'
                          }
                      }
                  }
              }
          },
          gauge: {
              startAngle: 225,
              endAngle: -45,
              axisLine: {
                  show: true,
                  lineStyle: {
                      color: [[0.2, '#86b379'], [0.8, '#68a54a'], [1, '#408829']],
                      width: 8
                  }
              },
              axisTick: {
                  splitNumber: 10,
                  length: 12,
                  lineStyle: {
                      color: 'auto'
                  }
              },
              axisLabel: {
                  textStyle: {
                      color: 'auto'
                  }
              },
              splitLine: {
                  length: 18,
                  lineStyle: {
                      color: 'auto'
                  }
              },
              pointer: {
                  length: '90%',
                  color: 'auto'
              },
              title: {
                  textStyle: {
                      color: '#333'
                  }
              },
              detail: {
                  textStyle: {
                      color: 'auto'
                  }
              }
          },
          textStyle: {
              fontFamily: 'Arial, Verdana, sans-serif'
          }
      };

    var myChart = echarts.init(document.getElementById('mainb'),theme);

    var option = {
        title : {
            text: 'Jumlah Fasyankes Yang Terlayani',
            subtext: 'Tahun '+{{ now()->year }}
        },
        tooltip : {
            trigger: 'axis'
        },
        legend: {
            x: 'center',
            y: 'bottom', 
            data:['RS. Pemerintah','RS. TNI/POLRI','RS. BUMN','RS. Swasta','Puskesmas','Klinik','Perusahaan','Lain - Lain']
        },
        toolbox: {
            show: true,
            feature: {
                magicType: {
                    show: true,
                    title: {
                        line: 'Line',
                        bar: 'Bar',
                        stack: 'Stack',
                        tiled: 'Tiled'
                    },
                    type: ['line', 'bar', 'stack', 'tiled']
                },
                dataView: {
                    show: true,
                    title: "Text View",
                    lang: [
                        "Tampil Data",
                        "Tutup",
                        "Refresh",
                    ],
                    readOnly: false
                },
                restore: {
                    show: true,
                    title: "Restore"
                },
                saveAsImage: {
                    show: true,
                    title: "Save"
                }
            }
        },
        calculable : true,
        xAxis : [
            {
                type : 'category',
                data : [
                    @foreach($list_provinsi as $list_provinsis)
                        {!! '\''.$list_provinsis->provinsi.'\',' !!}
                    @endforeach
                ]
            }
        ],
        yAxis : [
            {
                type : 'value'
            }
        ],
        series : [
            {
                name:'RS. Pemerintah',
                type:'bar',
                data:[
                    @foreach($RS_Pemerintah as $RS_Pemerintahs)
                        {!! $RS_Pemerintahs->RS_Pemerintah.',' !!}
                    @endforeach
                ],
                markPoint : {
                    data : [
                        {type : 'max', name: '最大值'},
                        {type : 'min', name: '最小值'}
                    ]
                },
                markLine : {
                    data : [
                        {type : 'average', name: '平均值'}
                    ]
                }
            },
            {
                name:'RS. TNI/POLRI',
                type:'bar',
                data:[
                    @foreach($RS_TNI_POLRI as $RS_TNI_POLRIs)
                        {!! $RS_TNI_POLRIs->RS_TNI_POLRI.',' !!}
                    @endforeach
                ],
                markPoint : {
                    data : [
                        {name : '年最高', value : 182.2, xAxis: 7, yAxis: 183},
                        {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3}
                    ]
                },
                markLine : {
                    data : [
                        {type : 'average', name : '平均值'}
                    ]
                }
            },
            {
                name:'RS. BUMN',
                type:'bar',
                data:[
                    @foreach($RS_BUMN as $RS_BUMNs)
                        {!! $RS_BUMNs->RS_BUMN.',' !!}
                    @endforeach
                ],
                markPoint : {
                    data : [
                        {name : '年最高', value : 182.2, xAxis: 7, yAxis: 183},
                        {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3}
                    ]
                },
                markLine : {
                    data : [
                        {type : 'average', name : '平均值'}
                    ]
                }
            },
            {
                name:'RS. Swasta',
                type:'bar',
                data:[
                    @foreach($RS_Swasta as $RS_Swastas)
                        {!! $RS_Swastas->RS_Swasta.',' !!}
                    @endforeach
                ],
                markPoint : {
                    data : [
                        {name : '年最高', value : 182.2, xAxis: 7, yAxis: 183},
                        {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3}
                    ]
                },
                markLine : {
                    data : [
                        {type : 'average', name : '平均值'}
                    ]
                }
            },
            {
                name:'Puskesmas',
                type:'bar',
                data:[
                    @foreach($Puskesmas as $Puskesmass)
                        {!! $Puskesmass->Puskesmas.',' !!}
                    @endforeach
                ],
                markPoint : {
                    data : [
                        {name : '年最高', value : 182.2, xAxis: 7, yAxis: 183},
                        {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3}
                    ]
                },
                markLine : {
                    data : [
                        {type : 'average', name : '平均值'}
                    ]
                }
            },
            {
                name:'Klinik',
                type:'bar',
                data:[
                    @foreach($Klinik as $Kliniks)
                        {!! $Kliniks->Klinik.',' !!}
                    @endforeach
                ],
                markPoint : {
                    data : [
                        {name : '年最高', value : 182.2, xAxis: 7, yAxis: 183},
                        {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3}
                    ]
                },
                markLine : {
                    data : [
                        {type : 'average', name : '平均值'}
                    ]
                }
            },
            {
                name:'Perusahaan',
                type:'bar',
                data:[
                    @foreach($Perusahaan as $Perusahaans)
                        {!! $Perusahaans->Perusahaan.',' !!}
                    @endforeach
                ],
                markPoint : {
                    data : [
                        {name : '年最高', value : 182.2, xAxis: 7, yAxis: 183},
                        {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3}
                    ]
                },
                markLine : {
                    data : [
                        {type : 'average', name : '平均值'}
                    ]
                }
            },
            {
                name:'Lain - Lain',
                type:'bar',
                data:[
                    @foreach($Lain_Lain as $Lain_Lains)
                        {!! $Lain_Lains->Lain_Lain.',' !!}
                    @endforeach
                ],
                markPoint : {
                    data : [
                        {name : '年最高', value : 182.2, xAxis: 7, yAxis: 183},
                        {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3}
                    ]
                },
                markLine : {
                    data : [
                        {type : 'average', name : '平均值'}
                    ]
                }
            }
        ]
    };

    myChart.hideLoading();
    myChart.setOption(option);


    var echartPieCollapse = echarts.init(document.getElementById('echart_pie2'), theme);

    echartPieCollapse.setOption({
      title: {
        text: 'Jumlah Fasyankes Terlayani Per Kategori',
        sublink: 'http://bpfk-banjarbaru.go.id',
        subtext: 'Tahun '+{{ now()->year }},
        left: 'center',
        textStyle: {
            color: '#000'
        }
    },
        tooltip: {
              trigger: 'item',
              formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
        orient: 'vertical',
              x: 'left',
              y: 'top',
              data: [
                @foreach($pie as $pie)
                    {!! '\''.$pie->name.'\',' !!}
                @endforeach
              ]
            },
            toolbox: {
                show: true,
                feature: {
                magicType: {
                    show: true,
                    type: ['pie', 'funnel']
                },
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
                restore: {
                      show: true,
                      title: "Restore"
                },
                saveAsImage: {
                      show: true,
                      title: "Save Image"
                }
            }
        },
        calculable: true,
        series: [{
            name: 'Area Mode',
            type: 'pie',
            radius: [25, 90],
            center: ['50%', 170],
            roseType: 'area',
            x: '50%',
            max: 40,
            sort: 'ascending',
            data: [
                {!! $datapie !!}
            ]
        }]
    });




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
'KUTAI TIMUR': [ 117.19896794605769, 1.027392442650042 ] ,
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
'PENAJAM PASER UTARA': [ 116.57061843296998, -1.158225387034787 ] ,
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
'PASER': [ 116.08157006546922, -1.74528377974084 ] ,
'BENGKAYANG': [ 109.5746104971013, 1.015797443889054 ] ,
'MEMPAWAH': [ 109.17391247842124, 0.331069805577334 ] ,
'MURUNG RAYA': [ 114.27356586326481, -0.028759839745458 ] ,
'KUTAI KERTANEGARA': [ 116.5475867146705, 0.125324071048293 ] ,
'MALINAU': [ 115.72032711230115, 2.46621081597755 ] ,
'MAHAKAM ULU': [ 115.13463299987204, 0.769951728468681 ]
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

option = {
    title : {
        text: 'Fasyankes Yang Terlayani',
        subtext: 'Tahun '+{{ now()->year }},
        left: 'center'
    },
    tooltip : {
        trigger: 'item',
         formatter: function (params) {
            var value = (params.name + '').split('.');
            //value = value[1];
            //return params.seriesName + '<br/>' + params.name + ' : ' + value;
            return params.seriesName + '<br/>' +value[0]+'('+value[1]+')';
        }
    },
    
    visualMap: {
 
        pieces: [
                {min: 1, label: 'Tidak Laik Pakai', color: 'red'},
                {max: 1,color: '#02d116',label:'Laik Pakai'}
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
        map: 'kab_indo',
        label: {

            emphasis: {
                show: false
            }
        },
        aspectScale:0.95,
        roam: true,
        itemStyle: {
            normal: {
                areaColor: '#f6f6f6',//'#323c48',
                borderColor: '#111'
            },
            emphasis: {
                areaColor: '#2a333d'
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
                    show: false
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
    data: convertData({!! $petaku !!})
  }]
});
</script>
@stop
