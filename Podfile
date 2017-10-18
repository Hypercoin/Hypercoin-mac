# Podfile
use_frameworks!

platform :osx, '10.12'

target 'Hypercoin' do
    pod 'RxSwift',    '~> 4.0'
    pod 'RxCocoa',    '~> 4.0'
end

# RxTests and RxBlocking make the most sense in the context of unit/integration tests
target 'HypercoinTests' do
    pod 'RxBlocking', '~> 4.0'
    pod 'RxTest',     '~> 4.0'
end