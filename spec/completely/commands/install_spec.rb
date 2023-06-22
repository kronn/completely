require 'spec_helper'

describe Commands::Install do
  subject { described_class.new }

  context 'with --help' do
    it 'shows long usage' do
      expect { subject.execute %w[install --help] }
        .to output_approval('cli/install/help').diff(10)
    end
  end

  context 'without arguments' do
    it 'shows short usage' do
      expect { subject.execute %w[install] }
        .to output_approval('cli/install/no-args')
    end
  end

  context 'with only the program name argument' do
    context 'when the default script is not found' do
      it 'raises an error' do
        expect { subject.execute %w[install completely-test] }
          .to raise_approval('cli/install/missing-script').diff(8)
      end
    end

    context 'when the default script is found' do
      let(:expected_args) do
        %w[
          sudo
          cp
          completely.bash
          /usr/share/bash-completion/completions/completely-test
        ]
      end

      before do
        reset_tmp_dir
        File.write 'spec/tmp/completely.bash', 'not-important'
      end

      it 'copies the script', :focus do
        Dir.chdir 'spec/tmp' do
          allow(subject).to receive(:system).with(*expected_args).and_return true
          subject.execute %w[install completely-test]
          expect { subject.execute %w[install completely-test] }
            .to output_approval('cli/install/install-default')
        end
      end
    end
  end

  context 'with the program name argument and a script argument' do
    let(:expected_args) do
      %w[
        sudo
        cp
        README.md
        /usr/share/bash-completion/completions/completely-test
      ]
    end

    it 'copies the script' do
      allow(subject).to receive(:system).with(*expected_args).and_return true
      expect { subject.execute %w[install completely-test README.md] }
        .to output_approval('cli/install/install-specified')
    end
  end

  context 'with --dry' do
    it 'shows the command' do
      expect { subject.execute %w[install completely-test README.md --dry] }
        .to output_approval('cli/install/dry')
    end
  end

  context 'when none of the target directories is found' do
    it 'raises an error' do
      allow(subject).to receive(:completions_path).and_return nil
      expect { subject.execute %w[install completely-test README.md] }
        .to raise_approval('cli/install/no-completion-targets').diff(8)
    end
  end

  context 'when the target file exists' do
    it 'raises an error' do
      allow(subject).to receive(:target_exist?).and_return true
      expect { subject.execute %w[install completely-test README.md] }
        .to raise_approval('cli/install/target-exists').diff(8)
    end
  end
end
