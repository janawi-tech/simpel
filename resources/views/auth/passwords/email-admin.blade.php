@extends('layouts.app')

@section('content')

    <!-- Page -->
  <div class="page vertical-align text-center" data-animsition-in="fade-in" data-animsition-out="fade-out">
    <div class="page-content vertical-align-middle">
      <h2>Forgot Your Password ?</h2>
      <p>Input your registered email to reset your password</p>
      @if (session('status'))
            <div class="alert alert-success">
                {{ session('status') }}
            </div>
      @endif
      <form method="POST" role="form" action="{{ route('admin.password.email') }}" autocomplete="off">
        @csrf
        <div class="form-group form-material floating" data-plugin="formMaterial">
          <input id="email" type="email" class="form-control{{ $errors->has('email') ? ' is-invalid' : '' }}" name="email" value="{{ old('email') }}" required>
          <label class="floating-label" for="inputEmail">Your Email</label>
        </div>
        <div class="form-group">
          <button type="submit" class="btn btn-primary btn-block">Reset Your Password</button>
        </div>
      </form>

      <footer class="page-copyright">
        <p>Sistem Informasi Laboratorium LPFK Banjarbaru</p>
        <p>© 2018. All RIGHT RESERVED.</p>
        <div class="social">
          <a class="btn btn-icon btn-pure" href="javascript:void(0)">
          <i class="icon bd-twitter" aria-hidden="true"></i>
        </a>
          <a class="btn btn-icon btn-pure" href="javascript:void(0)">
          <i class="icon bd-facebook" aria-hidden="true"></i>
        </a>
          <a class="btn btn-icon btn-pure" href="javascript:void(0)">
          <i class="icon bd-google-plus" aria-hidden="true"></i>
        </a>
        </div>
      </footer>
    </div>
  </div>
  <!-- End Page -->
@endsection
