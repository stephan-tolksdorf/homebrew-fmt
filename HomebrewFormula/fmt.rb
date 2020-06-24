class Fmt < Formula
  desc "Open-source formatting library for C++"
  homepage "https://github.com/fmtlib/fmt"
  head "git://github.com/fmtlib/fmt.git", :using => :git

  stable do
    url "https://github.com/fmtlib/fmt/archive/31c3a24.tar.gz" # https://github.com/fmtlib/fmt/commit/31c3a24266ed517cb0ddac639ceab777d14d104a
    sha256 "be7ab0d9f60bb42d16728f356a68bc4eea8937442e6f6aebf6639f26bc810168"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", "-DBUILD_SHARED_LIBS=TRUE", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <iostream>
      #include <string>
      #include <fmt/format.h>
      int main()
      {
        std::string str = fmt::format("The answer is {}", 42);
        std::cout << str;
        return 0;
      }
    EOS

    system ENV.cxx, "test.cpp", "-std=c++11", "-o", "test",
                  "-I#{include}",
                  "-L#{lib}",
                  "-lfmt"
    assert_equal "The answer is 42", shell_output("./test")
  end
end
