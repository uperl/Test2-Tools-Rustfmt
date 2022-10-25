use Test2::V0 -no_srand => 1;
use Test2::Tools::Rustfmt;

subtest rustfmt_ok => sub {

  subtest 'good' => sub {

    is
      intercept { rustfmt_ok 'corpus/rustgood.rs' },
      array {
        event Pass => sub {
          call name => 'rustfmt corpus/rustgood.rs';
        };
        end;
      };

  };

  subtest 'bad' => sub {

    is
      intercept { rustfmt_ok 'corpus/rustbad.rs' },
      array {
        event Fail => sub {
          call name => 'rustfmt corpus/rustbad.rs';
          call facet_data => hash {
            field info => array {
              item hash sub {
                field tag => 'DIAG';
                field details => array {
                  item match qr{rustfmt --check corpus/rustbad.rs};
                  item match qr{rustbad.rs};
                };
                etc;
              };
              etc;
            };
            etc;
          };
        };
        end;
      };

  };

  subtest 'list' => sub {

    is
      intercept { rustfmt_ok ['corpus/rustbad.rs','corpus/rustgood.rs'] },
      array {
        event Fail => sub {
          call name => 'rustfmt corpus/rustbad.rs corpus/rustgood.rs';
        };
        end;
      };

  };

};

done_testing;


