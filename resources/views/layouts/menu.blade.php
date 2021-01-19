<div class="site-menubar site-menubar-light">
    <div class="site-menubar-body">
      <div>
        <div>
          <ul class="site-menu" data-plugin="menu">
            <li class="site-menu-category">Hi, {{ Auth::guard('admin')->user()->name}}</li>
            <li class="site-menu-item {{ Route::currentRouteNamed('admin.dashboard') ? 'active' : '' }}">
              <a href="{{ route('admin.dashboard') }}">
                <i class="site-menu-icon md-view-dashboard" aria-hidden="true"></i>
                <span class="site-menu-title">Dashboard</span>
              </a>
            </li>
          @if(Auth::guard('admin')->user()->groups==1)
            @if (in_array(Route::currentRouteName(),['page.pengguna']))
            <li class="site-menu-item has-sub active open">
            @else
            <li class="site-menu-item has-sub">
            @endif
              <a href="javascript:void(0)">
                <i class="site-menu-icon md-view-compact" aria-hidden="true"></i>
                <span class="site-menu-title">Admin</span>
                <span class="site-menu-arrow"></span>
              </a>
              <ul class="site-menu-sub">
                <li class="site-menu-item {{ Route::currentRouteNamed('page.pengguna') ? 'active is-shown' : '' }}">
                  <a href="{{ route('page.pengguna') }}">
                    <span class="site-menu-title">Pengguna</span>
                  </a>
                </li>
              </ul>
            </li>
            @endif


            @if(Auth::guard('admin')->user()->groups==1 OR Auth::guard('admin')->user()->groups==7 OR Auth::guard('admin')->user()->id==9 )
            <li class="site-menu-item {{ Route::currentRouteNamed('page.penerimaan') ? 'active' : '' }}">
              <a href="{{ route('page.penerimaan') }}">
                <i class="site-menu-icon md-remote-control" aria-hidden="true"></i>
                <span class="site-menu-title">Penerimaan Alat</span>
              </a>
            </li>
            <li class="site-menu-item {{ Route::currentRouteNamed('page.spk') ? 'active' : '' }}">
              <a href="{{ route('page.spk') }}">
                <i class="site-menu-icon md-file" aria-hidden="true"></i>
                <span class="site-menu-title">SPK</span>
              </a>
            </li>
            <li class="site-menu-item {{ Route::currentRouteNamed('page.penyerahan') ? 'active' : '' }}">
              <a href="{{ route('page.penyerahan') }}">
                <i class="site-menu-icon md-shopping-cart" aria-hidden="true"></i>
                <span class="site-menu-title">Penyerahan Alat</span>
              </a>
            </li>
            <li class="site-menu-item {{ Route::currentRouteNamed('page.bukti') ? 'active' : '' }}">
              <a href="{{ route('page.bukti') }}">
                <i class="site-menu-icon md-mail-send" aria-hidden="true"></i>
                <span class="site-menu-title">Bukti Penyerahan</span>
              </a>
            </li>
            @endif
            @if(Auth::guard('admin')->user()->groups==5 OR Auth::guard('admin')->user()->groups==1)
            <li class="site-menu-item {{ Route::currentRouteNamed('page.kuitansi') ? 'active' : '' }}">
              <a href="{{ route('page.kuitansi') }}">
                <i class="site-menu-icon md-card" aria-hidden="true"></i>
                <span class="site-menu-title">Kuitansi</span>
              </a>
            </li>
            @endif
          </ul>
        </div>
      </div>
    </div>

    <div class="site-menubar-footer">
      <a href="javascript: void(0);" class="fold-show" data-placement="top" data-toggle="tooltip"
        data-original-title="Settings">
        <span class="icon md-settings" aria-hidden="true"></span>
      </a>
      <a href="javascript: void(0);" data-placement="top" data-toggle="tooltip" data-original-title="Lock">
        <span class="icon md-eye-off" aria-hidden="true"></span>
      </a>
      <a href="javascript: void(0);" data-placement="top" data-toggle="tooltip" data-original-title="Logout">
        <span class="icon md-power" aria-hidden="true"></span>
      </a>
    </div>
  </div>
