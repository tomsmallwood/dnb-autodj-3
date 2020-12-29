from setuptools import setup, find_packages

setup(
    name='autodj',
    version='0.1',
    description='Automatic DJ program for drum and bass music',
    url='https://bitbucket.org/ghentdatascience/dj/',
    author='Len Vande Veire',
    packages=find_packages('src'),
    package_dir={'': 'src'},
    install_requires=[
                'colorlog==2.10.0',
                'Essentia',
                'joblib==0.11',
                'librosa==0.5.0',
                'numpy==1.12.1',
                'pyAudio==0.2.8',
                'scikit-learn==0.20.3',
                'scipy==0.19.0',
                'yodel==0.3.0',
                'llvmlite==0.32.1',
                'numba==0.47.0',
    ],
    include_package_data=True,
)
