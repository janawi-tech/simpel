@extends('layouts.app')

@section('content')


<div class="page vertical-align text-center" data-animsition-in="fade-in" data-animsition-out="fade-out">>
    <div class="page-content vertical-align-middle">
      <div class="panel">
        <div class="panel-body">
          <div class="brand">
            <img class="brand-img" src="../img/logo.png" alt="...">
            <h2 class="brand-text font-size-18">LPFK Banjarbaru</h2>
          </div>
          <form method="POST" action="{{ route('login') }}" autocomplete="off">
            @csrf

            <div class="form-group form-material floating" data-plugin="formMaterial">
              <input id="email" type="text" class="form-control{{ $errors->has('email') ? ' is-invalid' : '' }}" name="email" value="{{ old('email') }}" required autofocus>
              <label class="floating-label">Username</label>
            </div>
            <div class="form-group form-material floating" data-plugin="formMaterial">
              <input id="password" type="password" class="form-control{{ $errors->has('password') ? ' is-invalid' : '' }}" name="password" required>
              <label class="floating-label">Password</label>
            </div>
            <div class="form-group clearfix">
              <div class="checkbox-custom checkbox-inline checkbox-primary checkbox-lg float-left">
                <input type="checkbox" name="remember" {{ old('remember') ? 'checked' : '' }}>
                <label for="inputCheckbox">Remember me</label>
              </div>
              <a class="float-right" href="http://bpfk-banjarbaru.org" target="_blank">LPFK BJB {{ now()->year }}</a>
            </div>
            <button type="submit" class="btn btn-primary btn-block btn-lg mt-40">Sign in</button>
          </form>
        </div>
      </div>
    </div>
  </div>
@endsection
