<!-- Navigation Bar-->
        <header id="topnav">
            <div class="topbar-main">
                <div class="container-fluid">

                    <!-- Logo container-->
                    <div class="logo">
                        <!-- Text Logo -->
                        <!--<a href="index.html" class="logo">-->
                            <!--<span class="logo-small"><i class="mdi mdi-radar"></i></span>-->
                            <!--<span class="logo-large"><i class="mdi mdi-radar"></i> Abstack</span>-->
                        <!--</a>-->
                        <!-- Image Logo -->
                        <a href="{{ route('admin.dashboard') }}" class="logo">
                            <img src="../assets/images/main_logo.png" alt="" height="30" class="logo-small">
                            <img src="../assets/images/main_logo.png" alt="" height="30" class="logo-large">
                        </a>

                    </div>
                    <!-- End Logo container-->


                    <div class="menu-extras topbar-custom">

                        <ul class="list-unstyled topbar-right-menu float-right mb-0">

                            <li class="menu-item">
                                <!-- Mobile menu toggle-->
                                <a class="navbar-toggle nav-link">
                                    <div class="lines">
                                        <span></span>
                                        <span></span>
                                        <span></span>
                                    </div>
                                </a>
                                <!-- End mobile menu toggle-->
                            </li>

                            <li class="dropdown notification-list">
                                <a class="nav-link dropdown-toggle waves-effect waves-light nav-user" data-toggle="dropdown" href="#" role="button"
                                   aria-haspopup="false" aria-expanded="false">
                                    <img src="../img/image.jpg" alt="user" class="rounded-circle"> <span class="ml-1 pro-user-name">{{ Auth::guard('admin')->user()->name}} <i class="mdi mdi-chevron-down"></i> </span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right profile-dropdown ">
                                    <!-- item-->
                                    <div class="dropdown-item noti-title">
                                        <h6 class="text-overflow m-0">Welcome !</h6>
                                    </div>

                                    <a href="{{ route('admin.logout') }}" class="dropdown-item notify-item">
                                        <i class="fi-power"></i> <span>Logout</span>
                                    </a>

                                </div>
                            </li>
                        </ul>
                    </div>
                    <!-- end menu-extras -->

                    <div class="clearfix"></div>

                </div> <!-- end container -->
            </div>
            <!-- end topbar-main -->

            <div class="navbar-custom">
                <div class="container-fluid">
                    <div id="navigation">
                        <!-- Navigation Menu-->
                        <ul class="navigation-menu">
                            @if(Auth::guard('admin')->user()->groups==1 OR Auth::guard('admin')->user()->groups==3 OR Auth::guard('admin')->user()->id==9 )
                            <li class="has-submenu {{ Route::currentRouteNamed('admin.dashboard') ? 'active' : '' }}">
                                <a href="{{ route('admin.dashboard') }}"><i class="fi-air-play"></i>Dashboard</a>
                            </li>

                            <li class="has-submenu {{ Route::currentRouteNamed('page.penerimaan') ? 'active' : '' }}">
                                <a href="{{ route('page.penerimaan') }}"><i class="fi-archive"></i>Penerimaan Alat</a>
                            </li>

                            <li class="has-submenu">
                                <a href="{{ route('page.spk') }}"><i class="fi-file"></i>SPK</a>
                            </li>

                            <li class="has-submenu {{ Route::currentRouteNamed('page.penyerahan') ? 'active' : '' }}">
                                <a href="{{ route('page.penyerahan') }}"><i class="fa fa-cubes"></i>Penyerahan Alat</a>
                            </li>

                            <li class="has-submenu {{ Route::currentRouteNamed('page.bukti') ? 'active' : '' }}">
                                <a href="{{ route('page.bukti') }}"><i class="fa fa-file-text-o"></i>Bukti Penyerahan</a>
                            </li>

                            <li class="has-submenu {{ Route::currentRouteNamed('page.dokumen') ? 'active' : '' }}">
                                <a href="{{ route('page.dokumen') }}"><i class="fa fa-file-text-o"></i>Upload Dokumen</a>
                            </li>

                            <li class="has-submenu">
                                <a href="javascript:void(0);"><i class="fa fa-file-excel-o"></i>Data - Data</a>
                                <ul class="submenu">
                                    <li class="{{ Route::currentRouteNamed('page.rekapalat') ? 'active' : '' }}"><a href="{{ route('page.rekapalat') }}">Rekap Alat per Tahun</a></li>
                                </ul>
                            </li>
                            @endif
                            
                            @if(Auth::guard('admin')->user()->groups==5 OR Auth::guard('admin')->user()->groups==1)
                            <li class="has-submenu {{ Route::currentRouteNamed('page.kuitansi') ? 'active' : '' }}">
                                <a href="{{ route('page.kuitansi') }}"><i class="fa fa-cc-amex"></i>Kuitansi</a>
                            </li>
                            @endif

                            @if(Auth::guard('admin')->user()->groups==1 OR Auth::guard('admin')->user()->groups==6)
                            @if (in_array(Route::currentRouteName(),['page.rekap-kabupaten','page.rekap-provinsi']))
                            <li class="has-submenu active">
                            @else
                            <li class="has-submenu">
                            @endif
                                <a href="javascript:void(0);"><i class="fa fa-file-excel-o"></i>Data - Data</a>
                                <ul class="submenu">
                                    <li class="{{ Route::currentRouteNamed('page.rekap-provinsi') ? 'active' : '' }}"><a href="{{ route('page.rekap-kabupaten') }}">Rekap Per Kabupaten</a></li>
                                    <li class="{{ Route::currentRouteNamed('page.rekap-provinsi') ? 'active' : '' }}"><a href="{{ route('page.rekap-provinsi') }}">Rekap Per Provinsi</a></li>
                                </ul>
                            </li>
                            @endif
                        </ul>
                        <!-- End navigation menu -->
                    </div> <!-- end #navigation -->
                </div> <!-- end container -->
            </div> <!-- end navbar-custom -->
        </header>
        <!-- End Navigation Bar-->